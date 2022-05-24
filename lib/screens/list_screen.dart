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

  Future<List<Users>> getListOfUsers() async {
    var uri = Uri.parse("https://reqres.in/api/users?page=2");
    var response = await http.get(uri);
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      final data = json.decode(response.body)['data'];
      List<Users> userList = data.mao<Users>((map){
        return Users.fromJson(map);
      }).toList();
      return userList;
    }else{
      throw Exception("Error Found");
    }
  }

  myApiWidget() {
    return FutureBuilder(
      future: getListOfUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(snapshot.data[index]['name']['first_name'] +
                            " " +
                            snapshot.data[index]['name']['last_name']+ " "),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapshot.data[index]['picture']['large'],
                          ),
                        ),
                        subtitle: Text(snapshot.data[index]['email']),
                      )
                    ],
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
