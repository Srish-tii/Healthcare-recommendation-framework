import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import 'ListDiseases.dart';

class Disease extends StatefulWidget{
  @override
  SelectDisease createState() => SelectDisease();
}
class SelectDisease extends State<Disease>{
  final _dname = TextEditingController();
  final _dcat = TextEditingController();
  final _dtype = TextEditingController();
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          textStyle: const TextStyle(fontSize: 20)),
      child: Text("OK"),
      onPressed: (){ Navigator.push(context,
          MaterialPageRoute(builder: (context)=> MyApp()));},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exit"),
      content: Text("Do you want to exit !"),
      actions: [
        okButton,],
      elevation: 24.0,
      backgroundColor: Colors.blueGrey[200],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alert );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (title: Text('Disease Page')),
      body:Container(
        child: SingleChildScrollView(
          child :Padding (
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child : Column (
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton( icon:Icon(Icons.home , color:Theme.of(context).primaryColor),
                    onPressed: (){Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> MyApp())); },
                  ),
                  SizedBox(height : 10),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child : TextFormField(
                      controller: _dname,
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Give disease name';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Disease name',
                        hintText: 'Disease name',
                        border : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.ac_unit),
                      ),),),
                  SizedBox(height : 10),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child : TextFormField(
                      controller: _dtype,
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Add the disease type';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Disease type',
                        hintText: 'Disease type',
                        border : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.category_outlined),
                      ),),),
                  SizedBox(height : 10),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child : TextFormField(
                      controller: _dcat,
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Add the disease category ';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Disease category',
                        hintText: 'Disease category',
                        border : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.category_rounded),
                      ),),),
                  SizedBox(height : 50),
                  MaterialButton(onPressed: () async{
                    List<String> data = [];
                    String dname = _dname.text ;
                    String dtype = _dtype.text ;
                    String dcat = _dcat.text ;
                    data.add(dname);
                    data.add(dtype);
                    data.add(dcat);
                    http.Response res = await createCoach(data) ;
                    if(res.statusCode == 200) {
                      AlertDialog show = AlertDialog(
                        title: Text("Disease created successfully "),
                        content: Text("Save and continue !"),
                        actions: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed:()=> {Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> MyApp())),
                                }, child: Text("Ok"),
                              ),
                              SizedBox(width: 10,),
                              TextButton(
                                onPressed:() => {Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> MyApp())),},
                                child: Text("exit"),),
                            ],  ),  ] ,
                        elevation: 24.0,
                        backgroundColor: Colors.blueGrey[200],
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => show );
                    }},
                      height: 50,
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white ,
                      shape :RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Save" ,
                        style: TextStyle(fontSize: 15, fontWeight :FontWeight.bold),)),
                  SizedBox(height : 50),
                  Row(
                    mainAxisAlignment : MainAxisAlignment.center ,
                    children : [
                      Text("Consult Diseases  :"),
                      SizedBox(width: 20),
                      TextButton(onPressed: () {Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> ListDisease ()));
                      },
                        child: Text("Disease List"),
                      ),],),
                ],),),),),),
    );
  }
}

///  ------------------------- Save data ---------------------------
Future<http.Response> createCoach(List<String> data) async{
  return http.post(Uri.parse('https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/disease.json'),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
    body: jsonEncode(<String, String>
    {
      "name" : data[0],
      "id_disease" : data[1],
      "id_category" : data[2],
    }),
  );
}