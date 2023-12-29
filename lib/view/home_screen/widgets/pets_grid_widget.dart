import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetsGridWidget extends StatelessWidget {
  PetsGridWidget({
    super.key,
    required this.title,
    required this.price,
    required this.place,
    required this.contact,
    required this.image,
  });

  String? title;
  String? price;
  String? place;
  String? contact;
  List<XFile?> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: BoxDecoration(
// shadow for container
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.8,
            spreadRadius: 0.8,
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.orange,
              image: DecorationImage(
                image: FileImage(File(image[0]!.path)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      maxLines: 1,
                    ),
                    SizedBox(height: 5),
                    Text(
                      price!,
                      maxLines: 1,
                    ),
                    SizedBox(height: 5),
                    Text(
                      place!,
                      maxLines: 1,
                    ),
                    SizedBox(height: 5),
                    Text(
                      contact!,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
