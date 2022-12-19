// ignore_for_file: unused_import, prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, deprecated_member_use, unused_local_variable, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:loginpage/updateapipost.dart';
import 'package:loginpage/viewpage.dart';

class updateprofile extends StatefulWidget {
   updateprofile({Key? key, required this.fname, required this.lname,
  required this.mobilenum,
  required this.phonenum, 
  required this.dates});

  late final String fname;
  final String lname;
  final String mobilenum;
  final String phonenum;
  final String dates;

  @override
  State<updateprofile> createState() => _updateprofileState();
}

class _updateprofileState extends State<updateprofile> {

  //final  form = GlobalKey<FormState>();

  late var fullname = TextEditingController(text: widget.fname);
  late var lastName = TextEditingController(text: widget.lname);
  late var mobile = TextEditingController(text: widget.mobilenum);
  late var phone = TextEditingController(text: widget.phonenum);
  late var dateOfBirth = TextEditingController(text: widget.dates);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('update profile')),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: fullname,
                  decoration: InputDecoration(
                    hintText: "full name",
                    labelText: "full name",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ),
                
              ),
              SizedBox(height: 10,),

               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: lastName,
                  decoration: InputDecoration(
                    hintText: "last Name",
                    labelText: "last Name",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ),
                
              ),
              SizedBox(height: 10,),

               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: mobile,
                  keyboardType:TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "mobile number",
                    labelText: "mobile number",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ),
                
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: phone,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "phone number",
                    labelText: "phone number",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ),
                
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onTap: () async {
                    
                    DateTime date = DateTime(1990);
                    FocusScope.of(context).requestFocus(FocusNode());
                    
                    date = (await showDatePicker(
                      context: context,
                       initialDate: DateTime.now(), 
                       firstDate: DateTime(1990), 
                       lastDate: DateTime(2100)))!;

                       dateOfBirth.text = date.toString().substring(0,10);

                  },
                  controller: dateOfBirth,
                  decoration: InputDecoration(
                    hintText: "dateOfBirth",
                    labelText: "dateOfBirth",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ),
                
              ),
              SizedBox(height: 10,),

              ElevatedButton.icon(
                //color: Colors.blue,
               onPressed: () async {
                 
                  

                    final fname = fullname.text;
                    final lname = lastName.text;
                    final mobilenum = mobile.text;
                    final phonenum = phone.text;
                    final dates = dateOfBirth.text;

                    print(fname);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('processing'),));

                    await postprofile(fname, lname, mobilenum, phonenum, dates);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('updated'),));

                   

               },
                icon: Icon(Icons.update, color: Colors.white,), 
                label: Text('update', style: TextStyle(color: Colors.white),)

                /*child: Text('update'),
                style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        
              )*/
              )
            ],
          ),
        ),
      ),

    );
  }
}