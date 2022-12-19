// ignore_for_file: unused_import, prefer_const_constructors, camel_case_types, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loginpage/image_upload.dart';
import 'package:loginpage/main.dart';
import 'package:loginpage/updateprofile.dart';
import 'package:loginpage/viewdata.dart';
import 'package:loginpage/viewpage.dart';
import 'package:loginpage/signature.dart';

class homepages extends StatefulWidget {

  const homepages({Key? key, required this.mailadd}) : super(key: key);
  final String mailadd;

  @override
  State<homepages> createState() => _homepagesState();
}

class _homepagesState extends State<homepages> {

  

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('home page')),
        ),
    
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                Center(child: Text('welcom to home page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                Text('${widget.mailadd}'),
                SizedBox(height: 50,),
    
              
                TextButton.icon(
                  onPressed: () {
                     signout();
                  },
                  icon: Icon(Icons.logout),
                  label: Text('signout'),
                ), 
                SizedBox(height: 50,),
                
                TextButton.icon(
                  onPressed: () {
                     signature();
                  },
                  icon: Icon(Icons.person),
                  label: Text('signature'),
                ), 

                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> imageUpload(staffId: '', woOrId: '',)));
                    },
                    icon: Icon(Icons.image),
                    label: Text('uploaded'),
                ),
              ],
            ),
          )
        ),
    
    
         drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  
                  DrawerHeader(
                    child: Center(
                      child: Text('cathodic', style: TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.bold,
                        fontSize: 30),),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    ),
                    ListTile(
                      trailing: Icon(Icons.update),
                      title: Text('update'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> view()));
                      },
                    ),
                    ListTile(
                      title: Text('view data'),
                      trailing: Icon(Icons.view_agenda),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => data()));
                      },
                    )
    
                ],
              )
              
          ),
    
      ),
    );
  }
  
  void signout() {
    Hive.box("mybox").clear();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage()));
  }
  
  void signature() {
     Navigator.push(context, MaterialPageRoute(builder: (context) => signa()));
  }
}