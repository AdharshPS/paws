import 'package:flutter/material.dart';
import 'package:paws_app/view/login_screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You are not currently logged in"),
          SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40,
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            child: Text("Login"),
          ),
        ],
      ),
    ));
  }
}
