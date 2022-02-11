import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Caregiver/CaregiverHome/PatientList.dart';
import 'package:rastreador/Patient/PatientHome/Recommendation.dart';
import 'package:rastreador/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


/// ***********  firestore try  **************
FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: secondaryApp);

/// *************** Firabase authentification  ***************
final FirebaseAuth _auth = FirebaseAuth.instance;

class Coachprofile extends StatefulWidget {
  @override
  Coachprof createState() {
   return  Coachprof();
  }
}
class Coachprof extends State<Coachprofile>{
  final User? user = _auth.currentUser ;
  final _fromKey = GlobalKey<FormState>();
  showAlertDialog(BuildContext context) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.push(context,
          MaterialPageRoute(builder: (context)=> MyApp()));},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Consult Patients List"),
      content: Text("Patients List"),
      actions: [
        okButton,
      ],);
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },);}
  @override
  Widget build(BuildContext context)  => DefaultTabController(
      initialIndex: 1,
      length : 2,
    child: Scaffold(
      appBar: AppBar(title: Text('Coach profile'),
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
        flexibleSpace: Container(height: 300, width: double.infinity,
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
              Tab(icon: Icon(Icons.run_circle_outlined),text:"Coach Advices"),
             ],),),
      body:  TabBarView(
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
                  // SizedBox(height : 10),
                  //  Text ('Welcome,'+ user!.uid ,style: TextStyle(
                  //     fontSize: 25.0,
                  //     color:Colors.blueGrey,
                  //     letterSpacing: 2.0,
                  //     fontWeight: FontWeight.w400
                  //     ),),
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
                          ],),),],),
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
                              Ink.image(image:  AssetImage('assets/PatPrac.jpg'),width:double.infinity,height:200 ,
                                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                child: InkWell(onTap: ()  {Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> PatientList()));}),
                                fit: BoxFit.cover,),
                              Text ('Patients Practices', style :TextStyle(fontWeight:FontWeight.bold,
                                  color: Colors.white, fontSize: 24 ),),
                            ], ),),],),
                  ],),),),),),
           Container(
                  child: Padding (
                    padding:EdgeInsets.all(12),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children :[
                        Card(color: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),),
                          child : Stack(
                            alignment: Alignment.center,
                            children: [
                              Ink.image(image:  AssetImage('assets/PatPrac.jpg'),width:double.infinity,height:200 ,
                                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                child: InkWell(onTap: ()  {Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> PatientList()));}),
                                fit: BoxFit.cover,),
                              Text ('Patients Practices', style :TextStyle(fontWeight:FontWeight.bold,
                                  color: Colors.white, fontSize: 24 ),),
                            ], ),),],), ),
  ),],),),);

  }

/*
Builder(builder :(BuildContext context) {
return Padding(
padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
child: Form(
key: _fromKey,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
Container (
height: 325,
width: double.infinity,
decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/vdoc3.jpg'),
fit: BoxFit.fill)),
),
Text('Coach Profile ', style: Theme.of(context).textTheme.headline6,),
RichText(
text: TextSpan(
text: 'Caregiver Name ',
children: const <TextSpan>[
TextSpan(text: 'Coach', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),],),),
Padding(
padding: const EdgeInsets.all(15.0),
child:ElevatedButton(
child: Text('Patient Lists'),
onPressed: () {Navigator.push(context,
MaterialPageRoute(
builder: (context) =>Coachprofile()));})),
Padding(
padding: const EdgeInsets.all(15.0),
child:ElevatedButton(
child: Text('Add New patient'),
onPressed: () {showAlertDialog(context);},),
),
Padding(
padding: const EdgeInsets.all(15.0),
child:ElevatedButton(
child: Text('Give Recommendation'),
onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => DoctPrescription()));},),),],),),);},),
);
 */

