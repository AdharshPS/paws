import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetsDetailsScreen extends StatefulWidget {
  PetsDetailsScreen(
      {super.key,
      required this.title,
      required this.price,
      required this.place,
      required this.contact,
      required this.image});

  List<XFile?> image;
  String? title;
  String? price;
  String? place;
  String? contact;

  State<PetsDetailsScreen> createState() => _PetsDetailsScreenState();
}

class _PetsDetailsScreenState extends State<PetsDetailsScreen> {
  @override
  build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  widget.image.length,
                  (index) => Container(
                    height: 300,
                    width: MediaQuery.sizeOf(context).width,
                    child: Image.file(
                      File(
                        widget.image[index]!.path,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(widget.title ?? ""),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 5),
                Text(widget.place ?? ""),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(widget.price ?? ""),
                Text("RS only"),
              ],
            ),
            SizedBox(height: 10),
            Text(widget.contact ?? ""),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
