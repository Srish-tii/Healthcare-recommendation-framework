
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http ;
import 'dart:math';
import 'syllables.dart';
/// --------------------Getting patients from firebase -------------------
Future<List<PatientNames>> fetchPatient(http.Client client) async {
 final response = await client.get(Uri.parse("https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/patient.json"));
 return compute(parsePatients, response.body);
}
List<PatientNames> parsePatients (String reponseBody){
  final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
  return parsed.map<PatientNames>((json) => PatientNames.fromJson(json)).toList();
}
/// ------------------------  functions -------------------------
const int maxSyllablesDefault = 2;
const bool safeOnlyDefault = true;
const int topDefault = 100;
final _random = Random();
Iterable<PatientNames> generateWordPairs({int maxSyllables = maxSyllablesDefault,
  int top = topDefault,
  bool safeOnly = safeOnlyDefault,
  Random? random}) sync* {
  final rand = random ?? _random;
  bool filterWord(String word) {
    if (safeOnly && unsafe.contains(word)) return false;
    return syllables(word) <= maxSyllables - 1;
  }
  List<String> shortAdjectives;
  List<String> shortNouns;
  if (maxSyllables == maxSyllablesDefault &&
      top == topDefault &&
      safeOnly == safeOnlyDefault) {
    // The most common, precomputed case.
    shortAdjectives = adjectivesMonosyllabicSafe;
    shortNouns = nounsMonosyllabicSafe;
  } else {
    shortAdjectives =
        adjectives.where(filterWord).take(top).toList(growable: false);
    shortNouns = nouns.where(filterWord).take(top).toList(growable: false);
  }
  String pickRandom(List<String> list) => list[rand.nextInt(list.length)];

  // We're in a sync* function, so `while (true)` is okay.
  // ignore: literal_only_boolean_expressions
  while (true) {
    String prefix;
    if (rand.nextBool()) {
      prefix = pickRandom(shortAdjectives);
    } else {
      prefix = pickRandom(shortNouns);
    }
    final suffix = pickRandom(shortNouns);

  // Skip combinations that clash same letters.
  if (prefix.codeUnits.last == suffix.codeUnits.first) continue;

  // Skip combinations that create an unsafe combinations.
  if (safeOnly && unsafePairs.contains("$prefix$suffix")) continue;

}
}
/// ----------------- Patient class ----------------------------------------
class PatientNames {
  final String firstname  ;
  final  String lastname ;

PatientNames ( {required this.firstname, required this.lastname}){
  if (firstname.isEmpty || lastname.isEmpty)
    {
      throw ArgumentError("Patient name cannot be empty. "
          "Received: '$firstname', '$lastname'");
    }
}
factory PatientNames.fromJson(Map<String, dynamic> json) {
  return PatientNames(
  firstname : json['first name'] as String,
  lastname : json ['last name'] as String,);}


 late final String asCamelCase = _createCamelCase();
 late final String asLowerCase = asString.toLowerCase();
 late final String asPascalCase = _createPascalCase();
 late final String asSnakeCase = _createSnakeCase();
 late final String asString = '$firstname$lastname';
 late final String asUpperCase = asString.toUpperCase();

 @override
 int get hashCode =>
     (firstname.hashCode.toString() + lastname.hashCode.toString()).hashCode;

 @override
 bool operator ==(Object other) {
   if (other is PatientNames) {
     return firstname == other.firstname && lastname == other.lastname;
   } else {
     return false;
   }
 }

 String join([String separator = '']) => '$firstname$separator$lastname';

 /// Creates a new [PatientName] with both parts in lower case.
// PatientNames toLowerCase() => PatientNames(firstname.toLowerCase(), lastname.toLowerCase(),);

 @override
 String toString() => asString;

 String _capitalize(String word) {
   return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
 }

 String _createCamelCase() => "${firstname.toLowerCase()}${_capitalize(lastname)}";

 String _createPascalCase() => "${_capitalize(firstname)}${_capitalize(lastname)}";

 String _createSnakeCase() => "${firstname}_${lastname}";
}

/// *IMPORTANT*: When adding to this list, edit also
/// `adjectivesMonosyllabicSafe` and `nounsMonosyllabicSafe`.
const List<String> unsafe = [
  'AIDS',
  'ass',
  'fucking',
  'gay',
  'Jew',
  'rape',
  'sex',
  'shit'
];

/// Lists combinations of perfectly innocent words that together create
/// a nasty one.
///
/// Partially sourced from:
/// http://onlineslangdictionary.com/lists/most-vulgar-words/
const List<String> unsafePairs = [
  'babyarm',
  'ballsack',
  'furpie',
  'getbrain',
  'hairpie',
  'nutbutter',
];
const List<String> adjectivesMonosyllabicSafe = [
  'new',
  'good',
  'high',
  'old',
  'great',
  'big',
  'small',
  'young',
  'black',
  'long',
  'bad',
  'white',
  'best',
  'right',
  'sure',
  'low',
  'late',
  'hard',
  'strong',
  'whole',
  'free',
  'true',
  'full',
  'clear',
  'red',
  'short',
  'wrong',
  'past',
  'fine',
  'poor',
  'hot',
  'dead',
  'left',
  'blue',
  'dark',
  'close',
  'cold',
  'main',
  'green',
  'nice',
  'huge',
  'wide',
  'top',
  'far',
  'deep',
  'tough',
  'safe',
  'rich',
  'key',
  'fresh',
  'front',
  'wild',
  'quick',
  'light',
  'bright',
  'warm',
  'French',
  'soft',
  'broad',
  'chief',
  'cool',
  'fair',
  'clean',
  'tall',
  'male',
  'dry',
  'sweet',
  'strange',
  'thin',
  'prime',
  'like',
  'thick',
  'sick',
  'slow',
  'brown',
  'just',
  'smart',
  'rare',
  'mean',
  'cheap',
  'gray',
  'tired',
  'vast',
  'sharp',
  'live',
  'weak',
  'fun',
  'sad',
  'brief',
  'mass',
  'joint',
  'grand',
  'glad',
  'fat',
  'still',
  'pure',
  'smooth',
  'due',
  'straight',
  'wet',
  'pink',
  'fast',
  'flat',
  'mad',
  'armed',
  'rough',
  'lost',
  'blind',
  'odd',
  'tight',
  'square',
  'raw',
  'loose',
  'mere',
  'pale',
  'round',
  'ill',
  'scared',
  'slight',
  'loud',
  'naked',
  'wise',
  'firm',
  'dear',
  'fit',
  'bare',
  'net',
  'harsh',
  'plain',
  'strict',
  'weird',
  'drunk',
  'mild',
  'bold',
  'steep',
  'shared',
  'rear',
  'Dutch',
  'Greek',
  'stiff',
  'faint',
  'near',
  'cute',
  'known',
  'dried',
  'pro',
  'shy',
  'gross',
  'damn',
  'fierce',
  'sole',
  'blank',
  'dumb',
  'neat',
  'calm',
  'blond',
  'brave',
  'skilled'
];
const List<String> nounsMonosyllabicSafe = [
'time',
'year',
'way',
'day',
'man',
'thing',
'life',
'child',
'world',
'school',
'state',
'group',
'hand',
'part',
'place',
'case',
'week',
'work',
'night',
'point',
'home',
'room',
'fact',
'month',
'lot',
'right',
'book',
'eye',
'job',
'word',
'side',
'kind',
'head',
'house',
'friend',
'hour',
'game', ];
const List<String> adjectives = [
'other',
'new',
'good',
'high',
'old',
'great',
'big',
'American',
'small',
'large',
'national',
'young',
'different',
'black',
'long',
'little',
'important',
'political',
'bad',
'white',
'real',
'best',
'right',
'social',
'only',
'public',
'sure',
'low',
'early',
'able',
'human',
'local',
'late',
'hard',
'major',
'better',
'economic',
'strong',
'possible',
'whole',
'free',
'military',
'true',
'federal',
'international',
'full',
'special',
'easy',
'clear',
'recent',
'certain',
'personal',
'open',
'red',
'difficult',
'available',
'likely',
'short',
'single',
'medical',
'current',
'wrong',
'private',
'past',
'foreign',
'fine',
'common',
'poor',];
const List<String> nouns = [
'time',
'year',
'people',
'way',
'day',
'man',
'thing',
'woman',
'life',
'child',
'world',
'school',
'state',
'family',
'student',
'group',
'country',
'problem',
'hand',
'part',
'place',
'case',
'week',
'company',
'system',
'program',
'question',
'work',
'government',
'number',
'night',
'point',
'home',
'water',
'room',
'mother',
'area',
'money',
'story',
'fact',
'month',
'lot',
'right',
'study',
'book',
'eye',
'job',
'word',
'business',
'issue',
'side',
'kind',
'head',
'house',
'service',
'friend',
'father',
'power',
'hour',
'game',
'line',
'end',
'member',
'law',
'car',
'city',
'community',
'name',
'president',
'team',
'minute',
'idea',
'kid',
'body',
'information',
'back',
'parent',
'face',
'others',
'level',
'office',
'door',
'health',
'person',
'art',
'war',];