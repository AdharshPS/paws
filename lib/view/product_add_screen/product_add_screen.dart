import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paws_app/database/db.dart';
import 'package:paws_app/model/pets_model.dart';
import 'package:paws_app/view/bottom_navigator_screen/bottom_navigator_screen.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  int itemIndex = 0;
  bool isSelected = false;

  final locationTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final contactTextController = TextEditingController();

  ImagePicker picker = ImagePicker();

  List<XFile?> pickedImageList = [];

  @override
  Widget build(BuildContext context) {
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
              isSelected == false
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
                            itemIndex = index;
                            isSelected = true;
                            setState(() {});
                          },
                          child: Text(DataBase.categories[index].name ?? ""),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width,
                          child: ElevatedButton(
                            onPressed: () {
                              isSelected = false;
                              pickedImageList.clear();
                              locationTextController.clear();
                              priceTextController.clear();
                              contactTextController.clear();
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DataBase.categories[itemIndex].name ?? ""),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    // image picker camera
                                                    XFile? image =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .camera);

                                                    pickedImageList.add(image);
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Icon(Icons
                                                        .camera_alt_outlined),
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
                                                  onTap: () async {
                                                    List<XFile?> images =
                                                        await picker
                                                            .pickMultiImage();
                                                    pickedImageList
                                                        .addAll(images);
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Icon(Icons
                                                        .photo_library_rounded),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: FileImage(
                                                  File(pickedImageList[index]!
                                                      .path),
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
                                                pickedImageList.removeAt(index);
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(1),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
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
                                      XFile? item =
                                          pickedImageList.removeAt(oldIndex);
                                      pickedImageList.insert(newIndex, item);
                                    },
                                  ),
                                ),

                                // Expanded(
                                //   child: SingleChildScrollView(
                                //     scrollDirection: Axis.horizontal,
                                //     child: Row(
                                //       children: List.generate(
                                //         pickedImageList.length,
                                //         (index) =>
                                // Padding(
                                //           padding:
                                //               const EdgeInsets.only(left: 10),
                                //           child: Stack(
                                //             children: [
                                //               Container(
                                //                 height: 60,
                                //                 width: 60,
                                //                 decoration: BoxDecoration(
                                //                   borderRadius:
                                //                       BorderRadius.circular(5),
                                //                   image: DecorationImage(
                                //                     image: FileImage(
                                //                       File(pickedImageList[
                                //                               index]!
                                //                           .path),
                                //                     ),
                                //                     fit: BoxFit.fill,
                                //                   ),
                                //                 ),
                                //               ),
                                //               Positioned(
                                //                 right: 0,
                                //                 top: 0,
                                //                 child: InkWell(
                                //                   onTap: () {
                                //                     pickedImageList
                                //                         .removeAt(index);
                                //                     setState(() {});
                                //                   },
                                //                   child: Container(
                                //                     padding: EdgeInsets.all(1),
                                //                     decoration: BoxDecoration(
                                //                       color: Colors.red,
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               5),
                                //                     ),
                                //                     child: Icon(
                                //                       Icons.remove,
                                //                       color: Colors.white,
                                //                       size: 20,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               )
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text("Long press to drag and sort"),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: locationTextController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "enter your location",
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: priceTextController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "enter the price",
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: contactTextController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "contact",
                          ),
                        ),
                        SizedBox(height: 50),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          child: ElevatedButton(
                            onPressed: () {
                              DataBase.petsList.add(
                                PetsModel(
                                  title:
                                      DataBase.categories[itemIndex].name ?? "",
                                  price: priceTextController.text,
                                  location: locationTextController.text,
                                  contact: contactTextController.text,
                                  image: pickedImageList,
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationBarScreen(),
                                ),
                              );
                              // isSelected = false;

                              setState(() {});
                            },
                            child: Text("Submit"),
                          ),
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
