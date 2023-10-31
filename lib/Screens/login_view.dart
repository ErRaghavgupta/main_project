import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:main_project/localStorage/shared_view.dart';
import 'package:main_project/routes/routes..dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var focusNode = FocusNode(),
      focusNode2 = FocusNode();

  var emailController = TextEditingController(),
      passwordController = TextEditingController();

  bool passwordIcon = false;

  List<Map<String, dynamic>> iconList = [
    {"icon": Icons.facebook, "color": Colors.blue},
    {"icon": Icons.apple, "color": Colors.black},
    {"icon": Icons.network_cell_outlined, "color": Colors.red}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () {
            return FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              children: [
                const Text(
                  "Welcome to Login Screen",
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: focusNode,
                  validator: (value) {
                    if (value == null || value.isNotEmpty) {
                      return "Please enter an email";
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
                  focusNode: focusNode2,
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
                        icon: passwordIcon==false
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
                            .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        if (auth != null) {
                          Navigator.pushNamed(context, homeRoute);
                          var prefs = await Shared.getPrefs();
                          prefs.setBool(onboardingKey, true);
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
                                    "Error : ${e
                                        .code},\nPlease create an account"),
                              ),
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        elevation: 1.2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      "Login",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      textScaleFactor: 1.5,
                    )),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...iconList.map((e) =>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.amberAccent,
                            child: Icon(
                              e["icon"],
                              color: e["color"],
                            ),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      const TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600)),
                      // WidgetSpan(child: SizedBox(width: 10)),
                      TextSpan(
                          text: "Sign up",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, signUpRoute);
                            }),
                    ])),
              ],
            ),
          ),
        ));
  }
}
