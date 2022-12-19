// ignore_for_file: unused_import, prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, deprecated_member_use, unused_local_variable, use_build_context_synchronously, avoid_print, sort_child_properties_last

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loginpage/home.dart';
import 'package:loginpage/tokenpage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(myapp());

  WidgetsFlutterBinding.ensureInitialized();
  final applicationdocumentdir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(applicationdocumentdir.path);
  await Hive.openBox('mybox');


}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({Key? key,}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  bool hide = true;

  var usernameco = TextEditingController(text:"firdaus@cathodicme.com");
  var passwordcon = TextEditingController(text: "Firdaus");
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('login page')),
        ),


        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: usernameco,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'email address',
                    labelText: 'Email'
                  ),
                  
                ),
                SizedBox(height: 20,),

                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordcon,
                  obscureText: hide,
                  decoration: InputDecoration(
                    suffix: InkWell(
                      onTap: view,
                      child: Icon(
                        hide
                        ? Icons.visibility_off
                        : Icons.visibility,
                      ),
                    ),
                    
                    hintText: 'enter the password',
                    labelText: ''
                  ),
                ),

                ElevatedButton(

                  onPressed: () {
                    loginbtn();
                  },
                  child: Text('login', style: TextStyle(fontSize: 15, color: Colors.white),),
                )

              ],
            ),
          ),
        ),

       

      ),
    );
  }
  
  Future<void> loginbtn() async {

      if(passwordcon.text.isNotEmpty && usernameco.text.isNotEmpty){

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('processing ')));

          final message = jsonEncode(<String, String>{
            "email" : usernameco.text,
            "password" : passwordcon.text
          });

          var response = await http.post(Uri.parse("https://fsm.cathodicme.com/api/routes/login.php"), body:message);
          var dec = json.decode(response.body);

          print(dec);

          if(response.statusCode == 200 && dec["success"] == 1){

            var box = Hive.box('mybox');
            box.put('token', '${dec['token']}');
            box.put('userId', '${dec['userInfo']['userId']}');

            var to = box.get('token');

           // print(to);

            var mailadd = usernameco.text;

            Navigator.push(context, MaterialPageRoute(builder: (context)=> homepages(mailadd: mailadd)));

          }else if(dec["success"] == 0){
            var mailaddress = usernameco.text;
            var passs = passwordcon.text;

            Navigator.push(context, MaterialPageRoute(builder: (context) => token(mailaddress: mailaddress, passs: passs)));
            
          }else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect value'),));
          }

      }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('please fill all details'),));
      }


    
  }

  void view() {

    setState(() {
      hide = !hide;
    });

  }
}