class PetsModel {
  String? title;
  String? price;
  String? place;
  String? contact;
  String? image;

  PetsModel({
    required this.title,
    required this.price,
    required this.place,
    required this.contact,
    this.image,
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
