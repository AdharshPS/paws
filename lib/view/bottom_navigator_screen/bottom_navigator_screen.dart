import 'package:flutter/material.dart';
import 'package:paws_app/view/home_screen/home_screen.dart';
import 'package:paws_app/view/like_screen/like_screen.dart';
import 'package:paws_app/view/profile_screen/profile_screen.dart';
import 'package:paws_app/view/search_screen/search_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int itemIndex = 0;
  List<dynamic> screensList = [
    HomeScreen(),
    SearchScreen(),
    null,
    LikeScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: itemIndex,
        selectedItemColor: Colors.orange,
        selectedFontSize: 12,
        onTap: (value) {
          value == 2
              ? showModalBottomSheet(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  context: context,
                  builder: (context) => Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text("data"),
                      )
                    ],
                  ),
                )
              : itemIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "account",
          ),
        ],
      ),
      body: screensList[itemIndex],
    );
  }
}
