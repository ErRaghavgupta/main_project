import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:main_project/Model/todoModel.dart';
import '../Model/main_view_model.dart';

class ApiData extends StatefulWidget {
  const ApiData({super.key});

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  late Future<MainModel> data;

  @override
  void initState() {
    super.initState();
    data = mainData();
  }

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<MainModel>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return Center(child: Text("error : ${snapshot.hasError}"));
              } else if (snapshot.hasData) {
                // if (snapshot.data != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.todos!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.orange.shade300,
                      elevation: 1.2,
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              selectIndex = index;
                              setState(() {});
                              var db = FirebaseFirestore.instance;

                              db.collection("favoriteItems").add(TodoModel(
                                      id: snapshot.data!.todos![index].id,
                                      completed: snapshot
                                          .data!.todos![index].completed,
                                      todo: snapshot.data!.todos![index].todo,
                                      userId:
                                          snapshot.data!.todos![index].userId)
                                  .toMap());
                            },
                            icon: selectIndex == index
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border)),
                        leading: Text(
                          snapshot.data!.todos![index].userId.toString(),
                        ),
                        title: Text("${snapshot.data!.todos![index].todo}"),
                        subtitle: Text(
                            snapshot.data!.todos![index].userId!.toString()),
                      ),
                    );
                    // );
                  },
                );
                // }
              }
            }
            return Container();
          },
        ),

      ),
    );
  }

  Future<MainModel> mainData() async {
    String url = "https://dummyjson.com/todos";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      print(res.statusCode);
      var json = jsonDecode(res.body);
      return MainModel.fromJson(json);
    } else {
      return MainModel();
    }
  }
}
