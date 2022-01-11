import 'package:flutter/material.dart' ;
import 'PatientNames.dart';

class PatientList extends StatefulWidget {
  @override
  PatientNameState createState() => PatientNameState();
}
class PatientNameState extends State<PatientList> {
  final  _patientnames = <PatientNames> [];
  final _savedlist = Set<PatientNames>();
  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item){
        if(item.isOdd) return Divider();
        final index = item ~/2 ;
        if (index >= _patientnames.length){
          _patientnames.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_patientnames[index]);},);}
  Widget _buildRow(PatientNames pair){
    final alreadySaved = _savedlist.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle
          (fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.check_circle: Icons.check,
            color: alreadySaved ? Colors.greenAccent: null),
        onTap: (){
          setState(() {
            if(alreadySaved){
              _savedlist.remove(pair);
            } else {
              _savedlist.add(pair);}});});}
  void _pushSaved(){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context){
              final Iterable<ListTile>tiles = _savedlist.map((PatientNames pair){
                return ListTile(
                    title: Text(pair.asPascalCase,style: TextStyle(fontSize: 16.0)));});
              final List<Widget> divided = ListTile.divideTiles(
                  context: context,
                  tiles: tiles
              ).toList();
              return Scaffold(
                  appBar: AppBar(title: Text('Selected Names')),
                  body: ListView(children: divided));}));}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(('Patient List')),
            actions: <Widget>[
              IconButton(
                  icon:Icon(Icons.list),
                  onPressed: _pushSaved)
            ]
        ),
        body: _buildList());
  }
  }
