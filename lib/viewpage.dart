// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'package:flutter/material.dart';
import 'package:loginpage/updateapi.dart';
import 'package:loginpage/updatemodel.dart';
import 'package:loginpage/updateprofile.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {

    var fullname = TextEditingController();
    var lastName = TextEditingController();
    var mobile = TextEditingController();
    var phone = TextEditingController();
    var dateOfBirth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('view page')),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          final resul = await getdata();
          setState(() {
            Future.value(resul);
          });
        },
        child: SingleChildScrollView(
          physics:  const AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(top: 100),
      
            
            child: Column(
              children: [
      
                FutureBuilder<userinfo>(
                  future: getdata(),
                  builder: ((context, snapshot) {
      
                    if(snapshot.hasData){
      
                          final data = snapshot.data;
                          return Column(
                            children: [
                              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Fullname', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle: Text(data!.fullName),
                  ),
                  
                ),
                SizedBox(height: 10,),
      
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('lastName', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle: Text(data.lastName),
                  ),
                  
                ),
                SizedBox(height: 10,),
      
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('mobile number', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle: Text(data.mobile),
                  ),
                  
                ),
                SizedBox(height: 10,),
      
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('phone number', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle: Text(data.phone),
                  ),
                  
                ),
                SizedBox(height: 10,),
      
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text('dateofbirth', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle: Text(data.dateOfBirth),
                  ),
                  
                ),
                SizedBox(height: 10,),
      
                ElevatedButton.icon(
                  //color: Colors.blue,
                 onPressed: () {
      
                    var fname = data.fullName.toString();
                    var lname = data.lastName.toString();
                    var mobile = data.mobile.toString();
                    var phone = data.phone.toString();
                    var date = data.dateOfBirth.toString();
      
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> updateprofile(fname : fname, lname: lname, mobilenum: mobile, phonenum: phone, dates: date)));
                 },
                  icon: Icon(Icons.update, color: Colors.white,), 
                  label: Text('Edit', style: TextStyle(color: Colors.white),)

                  //child: Text('Edit'),
                /*style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        
              )*/

                )
      
                            ],
                          );
      
                    }
      
                    return const CircularProgressIndicator();
                    
                  })),
      
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}