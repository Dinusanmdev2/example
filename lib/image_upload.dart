//import 'dart:html';
// ignore_for_file: unnecessary_import, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';


class imageUpload extends StatefulWidget {
  final String staffId;
  final String woOrId;
// receive data from the FirstScreen as a parameter
  const imageUpload({ required this.woOrId, required this.staffId}) : super();

  @override
  _imageUploadState createState() => _imageUploadState();
}

class _imageUploadState extends State<imageUpload> {

  File? _image;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    print("hai");
    /*final File pickedImage =
    (await ImagePicker().pickImage(source: ImageSource.gallery)) as File;*/
    final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,imageQuality: 50);
    //final File pickedImage = File(await ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) => pickedFile!.path));
    if (pickedImage != null) {
      setState(() {
        // _image = pickedImageas File;
        _image = File(pickedImage.path);
      });
    }
  }
    /*setState(() {
      _image = File(pickedImage.path);
    });*/
    Future<void> uploadImage()async {
      var box = Hive.box('mybox');
      var TN = box.get('Token');
      /*setState(() {
        showSpinner = true ;
      });*/

      var stream = http.ByteStream(_image!.openRead());
      stream.cast();
      //var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));

      var length = await _image!.length();

      var uri = Uri.parse('https://Fsm.cathodicme.com/api/routes/wo-upload-files.php');

      var request = http.MultipartRequest('POST', uri);
      print(widget.woOrId);
      print(widget.staffId);
      String woId = widget.woOrId;
      String workerid = widget.staffId;

      String datetime = DateTime.now().toString();

     // request.fields['title'] = "Test upload";
      request.fields['woId'] =widget.woOrId;
      request.fields['workerId'] = widget.staffId;
      request.fields['fileType'] = "img";
      request.fields['fileName'] = datetime;
      request.headers['Authorization'] = "Bearer $TN";

      var multiport = http.MultipartFile('sendFile', stream, length,filename: basename(_image!.path));
      print(_image!.path);

      request.files.add(multiport);

      var response = await request.send();
      /*http.Response response = await http.Response.fromStream(await request.send());
      print("Result: ${response.statusCode}");*/

      print(response.stream.toString());
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);

      });
      if (response.statusCode == 200) {

       ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(content:Text("Image Uploaded")));
        print(response.statusCode );
        print('image uploaded');
        print(response);
      } else {
        ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(content:Text("Uploaded Failed")));
        print('failed');
        print(response.statusCode );
        /*setState(() {
          showSpinner = false ;
        });*/
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(children: [
            Center(
              child: ElevatedButton(
                child: const Text('Select An Image'),
                onPressed: _openImagePicker,
              ),
            ),
            const SizedBox(height: 35),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.cover)
                  : const Text('Please select an image'),
            ),
            Center(
              child: ElevatedButton(
                  child: const Text('Upload Image'),
                  onPressed: () async{
                    //await AWSClient().uploadData("flutter", "my image", _image);
                    await uploadImage();
                  }
              ),
            ),
          ]),
        ),
      )
      /*Column(
        children: [
          Text(widget.woOrId),
          Text(widget.staffId),
        ],
      ),*/
    );
  }
}
