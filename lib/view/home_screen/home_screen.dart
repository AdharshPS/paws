import 'package:flutter/material.dart';
import 'package:paws_app/database/db.dart';
import 'package:paws_app/global_widgets/categories_widget.dart';
import 'package:paws_app/view/home_screen/widgets/pets_grid_widget.dart';
import 'package:paws_app/view/view_category_screen/view_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomecCreenState();
}

class _HomecCreenState extends State<HomeScreen> {
  List<String> cat = ["cat", "dog", "puppy", "cow"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.orange,
              title: Text("PAWS"),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 410,
                  child: Column(
                    children: [
                      CategoriesWidget(),
                      SizedBox(height: 10),

// necessarry button need for values
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewCategoryScreen(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * .25),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.orange[600]),
                          ),
                          child: Text(
                            "View All Categories",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

// gridview
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: DataBase.petsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 290,
                  ),
                  itemBuilder: (context, index) => PetsGridWidget(
                    title: DataBase.petsList[index].title,
                    price: DataBase.petsList[index].price,
                    place: DataBase.petsList[index].location,
                    contact: DataBase.petsList[index].contact,
                    image: DataBase.petsList[index].image,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
