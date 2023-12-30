import 'package:image_picker/image_picker.dart';

class PetsModel {
  String? title;
  String? price;
  String? location;
  String? contact;
  List<XFile?> image = [];

  PetsModel({
    required this.title,
    required this.price,
    required this.location,
    required this.contact,
    required this.image,
  });
}

class Categories {
  String? name;
  String? image;
  Categories({
    required this.name,
    required this.image,
  });
}
