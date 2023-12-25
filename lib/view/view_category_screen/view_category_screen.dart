import 'package:flutter/material.dart';
import 'package:paws_app/global_widgets/categories_widget.dart';

class ViewCategoryScreen extends StatelessWidget {
  const ViewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("select category"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: CategoriesWidget(
          viewAll: true,
        ),
      ),
    );
  }
}
