// ignore_for_file: unused_import, prefer_const_constructors, camel_case_types, avoid_unnecessary_containers, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/home.dart';

class token extends StatefulWidget {
  const token({Key? key, required this.mailaddress, required this.passs}) : super(key: key);
  final String mailaddress,passs;

  @override
  State<token> createState() => _tokenState();
}

class _tokenState extends State<token> {

  var tokenmsg = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('tokenpage')),
      ),

      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: tokenmsg,
              decoration: InputDecoration(
                hintText: 'enter the token',
                labelText: 'Token'
              ),
            ),

            ElevatedButton(
              //color: Colors.blue,
              onPressed: () {
                process();
              },
              child: Text('submit', style: TextStyle(color: Colors.white),),
            ),

          ],
        ),
      ),


    );
  }
  
  Future<void> process() async {
    var tok = tokenmsg.text;
    if(tok.isNotEmpty){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('processing'),));

        final msg = jsonEncode( <String, String>
        {
          "email" : widget.mailaddress,
          "password" : widget.mailaddress
        }
        );

          var response = await http.post(Uri.parse("https://fsm.cathodicme.com/api/routes/login.php"), body:msg);
          var dec = json.decode(response.body);

          if(response.statusCode == 200 && dec['success'] == 1){

             var mail = widget.mailaddress;

             Navigator.push(context, MaterialPageRoute(builder: (context)=> homepages(mailadd: mail)));            

          }else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('invalid'),));
          }

    }else{

    }
  }
}