import 'package:flutter/material.dart';
import 'package:paws_app/database/db.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({
    this.viewAll = false,
    super.key,
  });

  bool viewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          itemBuilder: (context, index) => Container(
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
        ),
      ],
    );
  }
}
