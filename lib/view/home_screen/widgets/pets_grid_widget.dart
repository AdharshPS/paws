import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paws_app/view/pets_details_screen/pets_details_screen.dart';

class PetsGridWidget extends StatefulWidget {
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
  State<PetsGridWidget> createState() => _PetsGridWidgetState();
}

class _PetsGridWidgetState extends State<PetsGridWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetsDetailsScreen(
              image: widget.image,
              title: widget.title,
              contact: widget.contact,
              price: widget.price,
              place: widget.place,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
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
                      image: FileImage(File(widget.image[0]!.path)),
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
                            widget.title ?? "",
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.price ?? "",
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.place ?? "",
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.contact ?? "",
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              onTap: () {
                isFavorite == false ? isFavorite = true : isFavorite = false;
                setState(() {});
              },
              child: isFavorite == false
                  ? Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
