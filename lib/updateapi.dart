// ignore_for_file: unused_import, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:loginpage/updatemodel.dart';
import 'package:http/http.dart' as http;

Future<userinfo> getdata() async{

  var box = Hive.box('mybox');
  var token = box.get('token');
  var uid = box.get('userId');

  Map<String, String> head = {
        "Authorization" : "Bearer ${token}",
  };

  final body = jsonEncode(<String, String> {"userId" : uid});

  var url = "https://fsm.cathodicme.com/api/routes/get-user-info.php";

  final response = await http.post(Uri.parse(url), headers: head, body: body );
  //var dec = json.decode(response.body);

  if(response.statusCode == 200){
    var jsonresponse = json.decode(response.body);

    return userinfo.fromJson(jsonresponse);
  }else{
    throw Exception('wrong API');
  }

}
