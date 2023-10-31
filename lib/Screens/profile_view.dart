import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/Model/usermodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var focusNode = FocusNode(),
      focusNode2 = FocusNode(),
      focusNode3 = FocusNode();

  var emailController = TextEditingController(),
      lastNameController = TextEditingController(),
      firstnameController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   db.collection("user").get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc["first_name"]);
  //       emailController = UserM;
  //       firstnameController = doc['firstName'];
  //       lastNameController = doc['lastName'];
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: db.collection("user").get(),
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
                  // var model = UserModel.fromJson(snapshot.data!.docs);
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var model =
                          UserModel.fromJson(snapshot.data!.docs[index].data());
                      emailController.text = model.email!;
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.add),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: firstnameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            focusNode: focusNode,
                            validator: (value) {
                              if (value == null || value.isNotEmpty) {
                                return "Please enter a name";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              return FocusScope.of(context)
                                  .requestFocus(focusNode2);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter a name",
                              prefixIcon: Icon(Icons.person),
                              label: const Text(
                                "Enter a name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: lastNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            focusNode: focusNode2,
                            validator: (value) {
                              if (value == null || value.isNotEmpty) {
                                return "Please enter a lastname";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              return FocusScope.of(context)
                                  .requestFocus(focusNode3);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter a last name",
                              prefixIcon: Icon(Icons.person),
                              label: const Text(
                                "Enter a last name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            focusNode: focusNode3,
                            validator: (value) {
                              if (value == null || value.isNotEmpty) {
                                return "Please enter an email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter an email",
                              prefixIcon: Icon(Icons.email),
                              label: const Text(
                                "Enter an email",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      );
                    },
                  );
                }
              }
              return Container();
            }),
      ),
    ));
  }
}
