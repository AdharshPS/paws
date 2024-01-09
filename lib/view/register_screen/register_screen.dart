import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paws_app/controller/login_or_register_controller.dart';
import 'package:paws_app/view/bottom_navigator_screen/bottom_navigator_screen.dart';
import 'package:paws_app/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPassword = false;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var functionProvider =
        Provider.of<AddUserController>(context, listen: false);
    // var variableProvider = Provider.of<LoginOrRegisterController>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Register",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  controller: emailTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    hintText: "email",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  controller: passwordTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Icon(Icons.password),
                    hintText: "password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (showPassword == true) {
                          showPassword = false;
                        } else {
                          showPassword = true;
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        showPassword == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: showPassword,
                  obscuringCharacter: "*",
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // await functionProvider.register(
                  //   email: emailTextController.text.trim().toLowerCase(),
                  //   password: passwordTextController.text.trim(),
                  // );

                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailTextController.text.trim().toLowerCase(),
                      password: passwordTextController.text.trim(),
                    );
                    if (credential.user?.uid != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigationBarScreen(),
                        ),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Register"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have an account ? "),
                  TextButton(
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
              )
            ],
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
