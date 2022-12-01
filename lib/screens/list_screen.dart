import 'dart:convert';
import 'package:appening/model_Class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: myApiWidget(),
    );
  }

  Future<List<dynamic>> getListOfUsers() async {
    var uri = Uri.parse("https://reqres.in/api/users?page=2");
    var response = await http.get(uri);
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final data2 = data['data'];
      print(data2);
      List<Users> userList = data2.map<Users>((map) {
        return Users.fromJson(map);
      }).toList();
      print(userList);
      return userList;
    } else {
      throw Exception("Error Found");
    }
  }

  myApiWidget() {
    return FutureBuilder<List<dynamic>>(
        future: getListOfUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!
                  .map((value) => ListTile(
                        title: Text(
                          value.first_name + " " + value.last_name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("${value.avatar}"),
                        ),
                        subtitle: Text(
                          value.email,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ))
                  .toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
