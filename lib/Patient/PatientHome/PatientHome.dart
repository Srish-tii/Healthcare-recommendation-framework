import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rastreador/Patient/Authentication/Register.dart';
import 'package:rastreador/Patient/Feedback/TestAlert.dart';
import 'package:rastreador/Patient/Feedback/Feedback.dart';
import 'package:rastreador/Patient/PatientHome/PatientInformation.dart';
import 'package:rastreador/Patient/PatientHome/Progress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'AddAct.dart';
import 'ListActivities.dart';
import 'PractTime.dart';
import '../../main.dart';
import 'package:geolocator/geolocator.dart';
import 'Disease.dart';
import 'Practices.dart';
import 'Recommendation.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
/// -------------------------- Getting patient Location ---------------------------
Position position =  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high) as Position;
enum LocationPermissionLevel {
  location,
  locationAlways,
  locationWhenInUse,
}
/// --------------------- Patient Profile Page  ----------------------------
class PatientProfile extends StatefulWidget {
  @override
  _Patient createState() {
    return _Patient();
  }}
class _Patient extends State<PatientProfile>{
  final User? user = _auth.currentUser ;
  CollectionReference patients = FirebaseFirestore.instance.collection('Patient');
  final String documentId = "";
  /// ************** Test user presence status **************
  @override
  Widget build(BuildContext context) => DefaultTabController(
    initialIndex: 1,
    length : 3 ,
    child : Scaffold(
      appBar: AppBar(title: Text('Patient Profile'),
        titleSpacing: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Notification',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No activity scheduled!')));
            },),
          Builder(builder: (BuildContext context) {
            // ignore: deprecated_member_use
            return FlatButton(
              child: const Text('Sign out'),
              textColor: Theme
                  .of(context)
                  .buttonColor,
              onPressed: () async {
                final User? user = _auth.currentUser ;
                if (user == null) {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                await _auth.signOut();
                final String uid = user.uid;
                // ignore: deprecated_member_use
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> MyApp()));
              },);}),
        ],
        elevation : 0,
        flexibleSpace: Container(
          height: 300,
          width: double.infinity,
          decoration: new BoxDecoration(
            color: const Color(0xff7c94b6),
            image :DecorationImage(image:AssetImage('assets/images.jpg'),
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                fit: BoxFit.cover),
          ),
        ),
        bottom: TabBar(
          indicatorColor: Colors.brown,
          indicatorWeight: 5,
          tabs :<Widget>[
            Tab(icon: Icon(Icons.home),text:"Home"),
            Tab(icon: Icon(Icons.run_circle_outlined),text:"Practices"),
            Tab(icon: Icon(Icons.upcoming_sharp),text:"Progress"),
          ],
        ),
      ),
//-------------   List of navigation pages in patient profile page   ---------
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[200],
              ),
              child: Text('Home '),

            ),
            ListTile(
              title: Text('Patient Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PatientProfile()),);
              },
            ),
            ListTile(
              title: Text('Consult Activities'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Practices()),);
              },
            ),
            ListTile(
              title: Text('Consult Progress'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PatientProgress()),);
              },
            ),
            ListTile(
              title: Text('Give Feedback'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()),);
              },
            ),
          ],
        ),
      ),
// --------------------------------- The body of patient page --------------------------------------
      body : TabBarView(
        children :<Widget>[
          Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all((20.0)),
                child : Form(
                  child : Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton( icon: Icon(Icons.face,
                          color:Theme.of(context).primaryColor ,
                          size: 50),
                          onPressed: (){ Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> MyApp()));}
                      ),
                      SizedBox(height : 10),
                      Text ('Welcome,'+ user!.uid ,style: TextStyle(
                          fontSize: 25.0,
                          color:Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400
                      ),),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children :[
                          Card(color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),),
                            child : Stack(
                              alignment: Alignment.center,
                              children: [
                                Ink.image(image:  AssetImage('assets/prescription.jpg'),width:double.infinity,height:200 ,
                                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                  child: InkWell(onTap: ()  {Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> Recommendation()));}),
                                  fit: BoxFit.cover,),
                                Text ('Recommendations', style :TextStyle(fontWeight:FontWeight.bold,
                                    color: Colors.black, fontSize: 24 ),),
                              ], ),),],),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children :[
                          Card(color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),),
                            child : Stack(
                              alignment: Alignment.center,
                              children: [
                                Ink.image(image:  AssetImage('assets/disease.jpg'),width:double.infinity,height:200 ,
                                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                  child: InkWell(onTap: ()  {Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> Disease()));}),
                                  fit: BoxFit.cover,),
                                Text ('Add Disease', style :TextStyle(fontWeight:FontWeight.bold,
                                    color: Colors.white, fontSize: 24 ),),
                              ], ),),],),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children :[
                          Card(color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),),
                            child : Stack(
                              alignment: Alignment.center,
                              children: [
                                Ink.image(image:  AssetImage('assets/sports.jpg'),width:double.infinity,height:200 ,
                                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                  child: InkWell(onTap: ()  {Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> WriteActivity()));}),
                                  fit: BoxFit.cover,),
                                Text ('Add Activity', style :TextStyle(fontWeight:FontWeight.bold,
                                    color: Colors.yellow[200], fontSize: 24 ),),
                              ], ),),],),
                      SizedBox(height:10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children :[
                          Card(color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),),
                            child : Stack(
                              alignment: Alignment.center,
                              children: [
                                Ink.image(image:  AssetImage('assets/feedback2.png'),width:double.infinity,height:200 ,
                                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                  child: InkWell(onTap: ()  {Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> MyLayout()));}),
                                  fit: BoxFit.cover,),
                                Text ('Give Feedback', style :TextStyle(fontWeight:FontWeight.bold,
                                    color: Colors.white, fontSize: 24 ),),
                              ], ),),],),
                      SizedBox(height: 10,),
                      Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children :[
                          Card(color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),),
                            child : Stack(
                              alignment: Alignment.center,
                              children: [
                                Ink.image(image:  AssetImage('assets/back5.jpg'),width:double.infinity,height:200 ,
                                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                                  child: InkWell(onTap: ()  {Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> GetPatientName(patients.path)));}),
                                  fit: BoxFit.cover,),
                                Text ('Update information:', style :TextStyle(fontWeight:FontWeight.bold,
                                    color: Colors.amberAccent, fontSize: 24 ),),
                              ], ),),],),],),),),),),
          Container (
            child : Padding (padding:EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),),
                    child : Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink.image(image:  AssetImage('assets/calendar.png'),width:double.infinity,height:200 ,
                          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                          child: InkWell(onTap: ()  {Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> PractTime()));}),
                          fit: BoxFit.cover,),
                        Text("Select Time" , style :TextStyle(fontWeight:FontWeight.bold,
                            color: Colors.black, fontSize: 24 ), ),
                      ],),),
                  Card(
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),),
                    child : Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink.image(image:  AssetImage('assets/sports.jpg'),width:double.infinity,height:200 ,
                          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                          child: InkWell(onTap: ()  {Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> LActivities()));}),
                          fit: BoxFit.cover,),
                        Text("Select Activity" , style :TextStyle(fontWeight:FontWeight.bold,
                            color: Colors.white, fontSize: 24 ), ),
                      ],),),
                ],),),),
          Container (
            child: Padding (
              padding : const EdgeInsets.all(20),
              child :  Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children : <Widget>[
                  Expanded (
                    child :IconButton(
                      icon: Icon(Icons.check_circle_outline,color:Theme.of(context).primaryColor ,
                          size: 80),
                      tooltip: 'Finished Activities',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No activity practiced!')));
                      },),),
                  Expanded (
                    child :Text ('Finished Activities',
                      semanticsLabel: '0',
                      softWrap: true,
                      style: TextStyle(fontStyle: FontStyle.italic),),),
                  Expanded (
                    child :IconButton(
                      icon: Icon(Icons.recent_actors_outlined ,color:Theme.of(context).primaryColor ,
                          size: 80),
                      tooltip: 'Finished Activities',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('patient progress')));
                      },),),
                  Expanded (
                    child :Text ('Health Progress',
                      semanticsLabel: '0',
                      softWrap: true,
                      style: TextStyle(fontStyle: FontStyle.italic),),),],),

            ),),], ),),);
}
/*

// ******************* Simple layout page *********************
body : SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all((20.0)),
            child : Form(
              child : Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton( icon: Icon(Icons.arrow_back_ios,
                    color:Theme.of(context).primaryColor ,),
                      onPressed: (){ Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> MyApp()));}
                  ),
                  SizedBox(height : 10),
                  Text ('Welcome,',style: TextStyle(fontStyle: FontStyle.italic),),
                  SizedBox(height: 10),
                  Container (
                    child :Row(
                      mainAxisAlignment : MainAxisAlignment.center ,
                      children : [
                        SizedBox(width: 5),
                        Expanded(child: Padding (
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                          child :  Image(
                              image: AssetImage('assets/progress.png'),width:110,height:90),),),
                        SizedBox(height: 10,),
                        TextButton(onPressed: () {Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> PatientProgress()));
                        },
                          child: Text("Consult progress"),
                        ),
                      ],),),
                  Container (
                    child :Row(
                      mainAxisAlignment : MainAxisAlignment.center ,
                      children : [
                        SizedBox(width: 5),
                        Expanded(child: Padding (
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                          child :  Image(
                              image: AssetImage('assets/Actfinished.png'),width:110,height:90),),),
                        SizedBox(height: 10,),
                        TextButton(onPressed: () {Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> Practices()));
                        },
                          child: Text("Select Activity"),
                        ),
                      ],),),
                  SizedBox(height: 30),
                 Row(
                   mainAxisAlignment : MainAxisAlignment.center ,
                   children :[
                   Text('Add new disease :'),
                   SizedBox(width: 5),
                   TextButton(onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> Disease()));
                      },
                      child: Text ('Disease'),
                   ),],),
                  SizedBox(width:30),
                  Row (
                    mainAxisAlignment : MainAxisAlignment.center ,
                    children :[
                      Text ('Give your Feedback :'),
                  TextButton(onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> FeedbackPage()));
                  },
                    child: Text("Feedback"),
                  ),],),
                      SizedBox(width: 30,),
                     Row (
                         mainAxisAlignment : MainAxisAlignment.center ,
                         children :[
                      Text ('Update your data :'),
                       TextButton(onPressed: () {Navigator.push(context,
                               MaterialPageRoute(builder: (context)=> Register()));
                           },
                         child: Text ('Update'),
                         ),],),
         ], ),
        ),
      ),
    ),),);
 */