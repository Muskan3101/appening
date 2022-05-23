import 'dart:convert';

import 'package:appening/model_Class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Users>>(
        future: getListOfUsers(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator()
            );
          }return ListView(
            children: snapshot.data!.map((value) => ListTile(
              title: Text(value.name),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            )).toList(),
          );
        },
      ),
    );
  }
  Future <List<Users>> getListOfUsers() async{
    var uri = Uri.parse("https://email-pass-auth-example-default-rtdb.firebaseio.com/users.json");
    var response = await http.get(uri);
    // print(response.body);
    // print(response.statusCode);
    if(response.statusCode == 200){
      // print(response.body);
      final data = json.decode(response.body);
      // print(data);
      List<Users> userList = data.map<Users>((map){
        return Users.fromJson(map);
      }).toList();
      return userList;
    }else{
      throw Exception("Some Error Found");
    }
  }
}
