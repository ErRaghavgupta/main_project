import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main_project/Screens/Sign_up_view.dart';
import 'package:main_project/Screens/apidata_view.dart';
import 'package:main_project/Screens/favdata_view.dart';
import 'package:main_project/Screens/home_view.dart';
import 'package:main_project/Screens/login_view.dart';
import 'package:main_project/Screens/onboarding_view.dart';
import 'package:main_project/Screens/profile_view.dart';
import 'package:main_project/Screens/splash_view.dart';
import 'package:main_project/firebase_options.dart';
import 'package:main_project/routes/routes..dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        if (settings.name == initialRoute) {
          return MaterialPageRoute(
            builder: (context) {
              return SplashView();
            },
          );
        } else if (settings.name == onboardingRoute) {
          return MaterialPageRoute(
            builder: (context) {
              return OnboardingView();
            },
          );
        } else if (settings.name == loginRoute) {
          return MaterialPageRoute(
            builder: (context) {
              return LoginView();
            },
          );
        } else if (settings.name == homeRoute) {
          return MaterialPageRoute(
            builder: (context) {
              return HomeView();
            },
          );
        } else if (settings.name == signUpRoute) {
          return MaterialPageRoute(
            builder: (context) => SignUp(),
          );
        } else if (settings.name == apiDataRoute) {
          return MaterialPageRoute(
            builder: (context) => ApiData(),
          );
        } else if (settings.name == favouriteRoute) {
          return MaterialPageRoute(
            builder: (context) => FavouriteDataView(),
          );
        } else if (settings.name == profileRoute) {
          return MaterialPageRoute(
            builder: (context) => ProfileView(),
          );
        }
      },
    );
  }
}
