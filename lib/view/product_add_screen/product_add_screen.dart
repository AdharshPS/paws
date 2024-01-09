import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paws_app/controller/product_add_screen_controller.dart';
import 'package:paws_app/database/db.dart';
import 'package:paws_app/view/bottom_navigator_screen/bottom_navigator_screen.dart';
import 'package:provider/provider.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  CollectionReference petsGrid =
      FirebaseFirestore.instance.collection('petsCollection');

  final locationTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final contactTextController = TextEditingController();

  List<XFile?> pickedImageList = [];

  @override
  Widget build(BuildContext context) {
    var variableProvider = Provider.of<ProductAddScreenController>(context);
    var functionProvider =
        Provider.of<ProductAddScreenController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("select a category"),
              SizedBox(height: 20),
              variableProvider.isSelected == false
                  ? Container(
                      padding: EdgeInsets.all(3),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: DataBase.categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          mainAxisExtent: 40,
                        ),
                        itemBuilder: (context, index) => ElevatedButton(
                          onPressed: () {
                            functionProvider.selectCategory(index);
                            priceTextController.clear();
                            locationTextController.clear();
                            contactTextController.clear();
                            pickedImageList.clear();
                          },
                          child: Text(DataBase.categories[index].name ?? ""),
                        ),
                      ),
                    )
                  : selectedCategory(
                      context, variableProvider, functionProvider),
            ],
          ),
        ),
      ),
    );
  }

  Column selectedCategory(
      BuildContext context,
      ProductAddScreenController variableProvider,
      ProductAddScreenController functionProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            onPressed: () {
              variableProvider.isSelected = false;
              pickedImageList.clear();
              locationTextController.clear();
              priceTextController.clear();
              contactTextController.clear();
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    DataBase.categories[variableProvider.itemIndex].name ?? ""),
                Icon(Icons.close),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Attach Image"),
            SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: () {
// alert dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Add Photo"),
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // image picker camera
                                    functionProvider.pickCameraimage(
                                        pickedImageList: pickedImageList,
                                        text1: locationTextController.text,
                                        text2: priceTextController.text,
                                        text3: contactTextController.text);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.camera_alt_outlined),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Take a photo")
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    functionProvider.pickMultiimage(
                                        pickedImageList: pickedImageList,
                                        text1: locationTextController.text,
                                        text2: priceTextController.text,
                                        text3: contactTextController.text);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.photo_library_rounded),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("From Gallery")
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(width: 10),
// picked images container

// reorder list
                SizedBox(
                  height: 60,
                  child: ReorderableListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: pickedImageList.length,
                    itemBuilder: (context, index) => Padding(
                      key: Key('$index'),
                      padding: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: FileImage(
                                  File(pickedImageList[index]!.path),
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: InkWell(
                              onTap: () {
                                functionProvider.deletePickedImage(
                                    index: index,
                                    pickedImageList: pickedImageList,
                                    text1: locationTextController.text,
                                    text2: priceTextController.text,
                                    text3: contactTextController.text);
                              },
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onReorder: (oldIndex, newIndex) {
                      setState(() {});
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      XFile? item = pickedImageList.removeAt(oldIndex);
                      pickedImageList.insert(newIndex, item);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Long press to drag and sort"),
          ],
        ),

// text fields
        SizedBox(height: 10),
        TextFormField(
          onChanged: (value) {
            functionProvider.textfieldsValidation(locationTextController.text,
                priceTextController.text, contactTextController.text);
          },
          controller: locationTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "enter your location",
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          onChanged: (value) {
            functionProvider.textfieldsValidation(locationTextController.text,
                priceTextController.text, contactTextController.text);
          },
          keyboardType: TextInputType.number,
          controller: priceTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "enter the price",
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          onChanged: (value) {
            functionProvider.textfieldsValidation(locationTextController.text,
                priceTextController.text, contactTextController.text);
          },
          keyboardType: TextInputType.phone,
          controller: contactTextController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "contact",
          ),
        ),
        SizedBox(height: 50),
// submit button
        SizedBox(
          height: 50,
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            onPressed: () async {
              if (variableProvider.isLoading == false) {
                variableProvider.isLoading = true;
                await functionProvider.imageStore(pickedImageList[0]);
                await functionProvider.addPets(
                  url: variableProvider.url,
                  price: priceTextController,
                  location: locationTextController,
                  contact: contactTextController,
                  pets: petsGrid,
                );
              } else {
                variableProvider.isLoading = false;
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavigationBarScreen(),
                ),
              );
              variableProvider.isLoading = false;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: variableProvider.isSubmitOkay == true
                  ? Colors.green
                  : Colors.red,
            ),
            child: variableProvider.isLoading == true
                ? CircularProgressIndicator()
                : Text("Submit"),
          ),
        ),
      ],
    );
  }
}
