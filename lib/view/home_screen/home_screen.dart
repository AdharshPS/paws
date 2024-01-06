import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paws_app/global_widgets/categories_widget.dart';
import 'package:paws_app/view/home_screen/widgets/pets_grid_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomecCreenState();
}

class _HomecCreenState extends State<HomeScreen> {
  CollectionReference petsGrid =
      FirebaseFirestore.instance.collection('petsCollection');

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
                      // Center(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => ViewCategoryScreen(),
                      //         ),
                      //       );
                      //     },
                      //     style: ButtonStyle(
                      //       padding: MaterialStatePropertyAll(
                      //         EdgeInsets.symmetric(
                      //             horizontal:
                      //                 MediaQuery.of(context).size.width * .25),
                      //       ),
                      //       backgroundColor:
                      //           MaterialStatePropertyAll(Colors.orange[600]),
                      //     ),
                      //     child: Text(
                      //       "View All Categories",
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: petsGrid.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
// gridview
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 290,
                          ),
                          itemBuilder: (context, index) {
// document snapshot
                            DocumentSnapshot pets = snapshot.data!.docs[index];
                            return PetsGridWidget(
                              title: pets['title'],
                              price: pets['price'],
                              place: pets['place'],
                              contact: pets['contact'],
                              image: pets['image'],
                              isFavorite: pets['favorite'],
                              pets: pets,
                            );
                          });
                    } else {
                      return Center(
                        child: Text("no data found"),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
