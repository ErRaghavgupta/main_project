import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_project/Model/todoModel.dart';

class FavouriteDataView extends StatefulWidget {
  const FavouriteDataView({super.key});

  @override
  State<FavouriteDataView> createState() => _FavouriteDataViewState();
}

class _FavouriteDataViewState extends State<FavouriteDataView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: db.collection("favoriteItems").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text("error : ${snapshot.hasError}"),
              );
              // else if()
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var model =
                      TodoModel.fromMap(snapshot.data!.docs[index].data());
                  return Card(
                    color: Colors.orange,
                    child: ListTile(
                      subtitle: Text(model.todo!),
                      trailing: Text(model.completed.toString()),
                      title: Text(model.id.toString()),
                    ),
                  );
                },
              );
            }
          }
          return Container();
        },
      ),
    ));
  }
}
