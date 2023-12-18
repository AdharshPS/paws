import 'package:flutter/material.dart';
import 'package:paws_app/database/db.dart';
import 'package:paws_app/view/home_screen/widgets/pets_grid_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomecCreenState();
}

class _HomecCreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("PAWS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 290,
          ),
          itemBuilder: (context, index) => Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    color: Colors.orange,
                  ),
                  PetsGridWidget(
                    title: DataBase().petsList[index].title,
                    price: DataBase().petsList[index].price,
                    place: DataBase().petsList[index].place,
                    contact: DataBase().petsList[index].contact,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
