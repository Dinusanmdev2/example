// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:loginpage/signaturepreview.dart';
import 'package:signature/signature.dart';

class signa extends StatefulWidget {
  const signa({Key? key}) : super(key: key);

  @override
  State<signa> createState() => _signatureState();
}

class _signatureState extends State<signa> {

   late SignatureController controler;

  @override
  void initState() {
    
    super.initState();

    controler = SignatureController(
      penColor: Colors.white
    );
  }

  @override
  void dispose() {
    controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signature bord'),
      ),

      body:
        Column(
          children: <Widget> [
      
            Signature(controller: controler, 
            height: MediaQuery.of(context).size.height-128,
            backgroundColor: Colors.black,),
      
            Spacer(),        
      
              buildbutton(context),
      
          ],
        ),
      

    );
  }
  
  buildbutton(BuildContext context) => Container(
    color: Colors.black,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget> [

        buldcheck(context),
        buildclear(),

      ],
    ),
  );
  
  buildclear() => IconButton(
    iconSize: 30,
    icon: Icon(Icons.clear, color: Colors.red,),
    onPressed: () => controler.clear(), 
  );
  
  buldcheck(BuildContext context) => IconButton(
    iconSize: 30,
    icon: Icon(Icons.check, color: Colors.blue,),
    onPressed: () async{
      if(controler.isNotEmpty){
        final singna = await exportSignature();

        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => signaturepreview(Signature: singna)));

      }
    },
  );
  
  Future <Uint8List?> exportSignature() async {
    final exportcontroler = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: controler.points
    );
    final signatur = await exportcontroler.toPngBytes();
    exportcontroler.dispose();

    return signatur;
  }
}