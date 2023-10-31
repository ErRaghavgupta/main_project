import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:main_project/Model/usermodel.dart';

import '../routes/routes..dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var focusNode = FocusNode(),
      focusNode2 = FocusNode(),
      focusNode3 = FocusNode(),
      focusNode4 = FocusNode();

  var emailController = TextEditingController(),
      passwordController = TextEditingController(),
      firstnameController = TextEditingController(),
      lastNameController = TextEditingController();

  bool passwordIcon = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
            const Text(
              "Welcome to SignUp Screen",
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                decorationStyle: TextDecorationStyle.dotted,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(
              height: 40,
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
                return FocusScope.of(context).requestFocus(focusNode2);
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
                return FocusScope.of(context).requestFocus(focusNode3);
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: focusNode3,
              validator: (value) {
                if (value == null || value.isNotEmpty) {
                  return "Please enter an email";
                }
                return null;
              },
              onFieldSubmitted: (value) {
                return FocusScope.of(context).requestFocus(focusNode4);
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
            TextFormField(
              obscureText: passwordIcon,
              controller: passwordController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              focusNode: focusNode4,
              validator: (value) {
                if (value == null || value.isNotEmpty) {
                  return "Please enter an password";
                }
                return null;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      passwordIcon = !passwordIcon;
                      setState(() {});
                    },
                    icon: passwordIcon == false
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                fillColor: Colors.white,
                filled: true,
                hintText: "Enter a password",
                prefixIcon: Icon(Icons.password),
                label: const Text(
                  "Enter a Password",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 34,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    var auth = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (firstnameController.text != "" &&
                        lastNameController.text != "") {
                      var db = FirebaseFirestore.instance;
                      db.collection("user").add(UserModel(
                              firstName: firstnameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text)
                          .toMap());

                      if (auth != null) {
                        Navigator.pushNamed(context, loginRoute);
                      }
                    }
                  } on FirebaseAuthException catch (e) {
                    // print("Error : ${e.code}");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: SizedBox(
                            height: 150,
                            width: 150,
                            child: Text(
                                "Error : ${e.code},\nPlease create an account"),
                          ),
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    elevation: 1.2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textScaleFactor: 1.5,
                )),
          ],
        ),
      ),
    ));
  }
}
