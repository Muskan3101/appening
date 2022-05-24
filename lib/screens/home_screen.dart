import 'dart:convert';
import 'package:appening/screens/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _globalFormKey = GlobalKey<FormState>();
  var fullName = " ";
  var jobName = " ";
  TextEditingController fullNameController = TextEditingController();
  TextEditingController jobNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4B94FF),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 40,
                    ),
                    const Text("FullName"),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        fullName = value!;
                        if (value.isEmpty) {
                          return "Please fill your full name";
                        }
                        return null;
                      },
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(9))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Job Name"),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value){
                        jobName = value!;
                        if(value.isEmpty){
                          return "Please fill your Job name";
                        }return null;
                      },
                      controller: jobNameController,
                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(9))),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: MaterialButton(
                        onPressed: () {
                          var valid = _globalFormKey.currentState!.validate();
                          if(valid){
                            return submitData() ;
                          }
                          return ;
                          },
                        minWidth: double.infinity,
                        height: 48,
                        color: const Color(0xFF4B94FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ));
  }

  void submitData() async {
    var uri = Uri.parse("https://reqres.in/api/users");
    var jsonData = json.encode(
        {"name": fullNameController.text, "job": jobNameController.text});
    var response = await http.post(uri, body: jsonData);
    print("data inserted");
    // print(response.body);
    if (response.statusCode == 201) {
      if (jsonData.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ListScreen()));
      }
    }
  }
}


