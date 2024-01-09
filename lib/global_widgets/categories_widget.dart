import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paws_app/database/db.dart';
import 'package:paws_app/view/search_screen/widgets/searched_pets_widget.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({
    this.viewAll = false,
    super.key,
  });

  bool viewAll;

  @override
  Widget build(BuildContext context) {
    CollectionReference petsGrid =
        FirebaseFirestore.instance.collection('petsCollection');
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Categories",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 10),
      GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: viewAll == true ? DataBase.categories.length : 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 130,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchedPetsWidget(
                      title: DataBase.categories[index].name,
                    ),
                  ),
                );
              },
              child: Container(
                // height: 100,
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      DataBase.categories[index].image ?? "",
                      height: 100,
                    ),
                    Text(
                      DataBase.categories[index].name ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    ]);
  }
}
