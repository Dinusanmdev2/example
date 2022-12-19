// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, unused_import, use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';

class signaturepreview extends StatelessWidget {
  const signaturepreview({Key? key, required this.Signature}) : super(key: key);
  final Uint8List? Signature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text('preview'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.done),
                onPressed: () => storageimage(context),
              )
            ],
          ),

          body: Center(
            child: Image.memory(Signature!),
          ),

    );
  }
  
  Future storageimage(BuildContext context) async {

          final status = await Permission.storage.status;
          if(!status.isGranted){
            await Permission.storage.request();
          }

          final time = DateTime.now().toIso8601String().replaceAll('.', ':');
          final name = 'signature$time.png';
          final result = await ImageGallerySaver.saveImage(Signature!, name: name);

          final isSuccess = result['isSuccess'];

          if(isSuccess){
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('save the signature'),));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('not save signature'),));
          }

  }
}