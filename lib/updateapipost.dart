// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps, unused_import, empty_statements

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;


Future postprofile(fname, lname, mobilenum, phonenum, dates) async {

        var box = Hive.box('mybox');
        var token = box.get('token');
  

        Map<String, String> head = {
            "Authorization" : "Bearer ${token}",
        };

        final body = jsonEncode(
          <String, String>{
            "fullName" : fname,
            "lastName" : lname,
            "mobile" : mobilenum,
            "phone" : phonenum,
            "dateOfBirth" : dates
          });

        var url = "https://fsm.cathodicme.com/api/routes/update-profile.php";

        final response = await http.post(Uri.parse(url), headers: head, body: body );
        var dec = json.decode(response.body);

        print("update response ${dec}");

        if(response.statusCode == 200){
              var jsonresponse = json.decode(response.body);
        
        }else{
            throw Exception('wrong API');
        };

}