import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetsDetailsScreen extends StatefulWidget {
  PetsDetailsScreen({super.key, required this.image});

  List<XFile?> image;

  State<PetsDetailsScreen> createState() => _PetsDetailsScreenState();
}

class _PetsDetailsScreenState extends State<PetsDetailsScreen> {
  @override
  build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Expanded(
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
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
