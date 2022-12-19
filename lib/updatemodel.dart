// ignore_for_file: unused_import, depend_on_referenced_packages, camel_case_types, empty_constructor_bodies


import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';


class userinfo{
      late String fullName;
      late String lastName;
      late String mobile;
      late String phone;
      late String dateOfBirth;

      userinfo({required this.fullName, required this.lastName, required this.mobile, required this.phone, required this.dateOfBirth});

      factory userinfo.fromJson(Map <String, dynamic> json){
        return userinfo(
          fullName: json['fullName'].toString(), 
          lastName: json['lastName'].toString(), 
          mobile: json['mobile'].toString(), 
          phone: json['phone'].toString(), 
          dateOfBirth: json['dateOfBirth'].toString(),
          );
      }

}