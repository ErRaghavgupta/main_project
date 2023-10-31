import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/Model/usermodel.dart';
import 'package:main_project/Screens/apidata_view.dart';
import 'package:main_project/Screens/profile_view.dart';
import 'package:main_project/localStorage/shared_view.dart';
import 'package:main_project/routes/routes..dart';

import 'favdata_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  var list = [ApiData(), FavouriteDataView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
          child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          ElevatedButton(
            // color: Colors.orange,
            // elevation: 2.5,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.orange,
              elevation: 1.5,
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileView(),));
            },
            child: const Row(children: [
              Icon(Icons.person),
              SizedBox(
                width: 15,
              ),
              Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.orange,
              elevation: 1.5,
            ),
            onPressed: () async {
              var auth = FirebaseAuth.instance;
              auth.signOut();
              var prefs = await Shared.getPrefs();
              prefs.remove(onboardingKey);
              Navigator.pushNamed(context, loginRoute);
            },
            child: const Row(children: [
              Icon(Icons.logout),
              SizedBox(
                width: 15,
              ),
              Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ]),
          ),
        ],
      )),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: const Text(
            "Api",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: list.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange.shade200,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: Colors.grey,
          // elevation:,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.data_exploration_sharp,
                color: Colors.yellow,
              ),
              label: "Data",
              // backgroundColor: Colors.red.shade100,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.red),
              label: "Favourite",
              // backgroundColor: Colors.red.shade100,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.blue),
              label: "Profile",
              // backgroundColor: Colors.red.shade100,
            ),
          ]),
    ));
  }
}
