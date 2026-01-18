
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:providerss/riverpod/dart_data_generator/models/user.dart';

Future<List<User>> fetchUsers()async{
  try{
     final response= await Dio().get('https://jsonplaceholder.typicode.com/users',
     options: Options(
      headers: {
      'Accept': 'application/json',
      'User-Agent': 'Mozilla/5.0',
    },
     )
     );
     final List userList=response.data;
     log(userList.runtimeType.toString());
     final users=[for(final user in userList) User.fromMap(user)];
     return users;
  }
  catch(e){
    rethrow;
  }
}