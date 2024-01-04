import 'package:flutter/material.dart';
import 'package:paws_app/controller/product_add_screen_controller.dart';
import 'package:paws_app/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD2low7gwk2rrvrf-irRVNyHoqY9-CSSFQ",
      appId: "1:582949241652:android:dfdf1f2f4b8d25b1f11b61",
      messagingSenderId: "",
      projectId: "paws-a6dd6",
      storageBucket: "paws-a6dd6.appspot.com",
    ),
  );
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductAddScreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
