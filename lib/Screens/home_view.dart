import 'package:flutter/material.dart';
import 'package:main_project/Screens/apidata_view.dart';
import 'package:main_project/Screens/profile_view.dart';

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
      appBar: AppBar(
          centerTitle: true,
          leading: DrawerButtonIcon(),
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
