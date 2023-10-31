import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:main_project/routes/routes..dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  List<Map<String, dynamic>> list = [
    {
      "image":
          "https://images.unsplash.com/photo-1698611028521-4c284ca88b11?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNHx8fGVufDB8fHx8fA%3D%3D",
      "title": "First Text",
      "subtitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "image":
          "https://plus.unsplash.com/premium_photo-1698507574258-69d0e564c695?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Second Text",
      "subtitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    },
    {
      "image":
          "https://plus.unsplash.com/premium_photo-1698516246435-2f11bda07526?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1OXx8fGVufDB8fHx8fA%3D%3D",
      "title": "Third Text",
      "subtitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    }
  ];

  int currentIndex = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView.builder(
        itemCount: list.length,
        controller: controller,
        onPageChanged: (value) {
          currentIndex = value;
          setState(() {});
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  list[index]["image"],
                  height: 300,
                  width: 350,
                  fit: BoxFit.cover,
                ),
                Text(
                  list[index]["title"],
                  textScaleFactor: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  list[index]["subtitle"],
                  textAlign: TextAlign.justify,
                  textScaleFactor: 1,
                ),
                DotsIndicator(
                  position: currentIndex,
                  onTap: (position) {
                    currentIndex = position;
                    setState(() {});
                  },
                  dotsCount: list.length,
                  decorator: DotsDecorator(),
                  axis: Axis.horizontal,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentIndex != 0
                        ? ElevatedButton(
                            onPressed: () {
                              controller.previousPage(
                                  duration: Duration(seconds: 2),
                                  curve: Curves.bounceOut);
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 1.2,
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text(
                              "Skip",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        : Container(),
                    currentIndex != 2
                        ? ElevatedButton(
                            onPressed: () {
                              controller.nextPage(
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.bounceInOut);
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 1.2,
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text(
                              "Next",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 1.2,
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: () {
                              Navigator.pushNamed(context, loginRoute);
                            },
                            child: const Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.amber.shade100,
    ));
  }
}
