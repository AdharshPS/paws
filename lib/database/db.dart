import 'package:paws_app/model/pets_model.dart';

class DataBase {
  static List<PetsModel> petsList = [
    PetsModel(
        title: "dog", price: "1000", place: "thrissur", contact: "7852845"),
    PetsModel(
        title: "cat", price: "2000", place: "malappuram", contact: "7852845"),
    PetsModel(
        title: "fish", price: "300", place: "ernakulam", contact: "7852845"),
    PetsModel(
        title: "bird", price: "2500", place: "wayanad", contact: "7852845"),
    PetsModel(
        title: "dog", price: "1000", place: "thrissur", contact: "7852845"),
    PetsModel(
        title: "cat", price: "2000", place: "malappuram", contact: "7852845"),
    PetsModel(
        title: "fish", price: "300", place: "ernakulam", contact: "7852845"),
    PetsModel(
        title: "bird", price: "2500", place: "wayanad", contact: "7852845"),
  ];

  static List<Categories> categories = [
    Categories(name: "Cat", image: "assets/images/cat_asset.jpg"),
    Categories(name: "Dog", image: "assets/images/dog_asset.png"),
    Categories(name: "Bird", image: "assets/images/cat_asset.jpg"),
    Categories(name: "Fish", image: "assets/images/dog_asset.png"),
    Categories(name: "Rabbit", image: "assets/images/cat_asset.jpg"),
    Categories(name: "Others", image: "assets/images/dog_asset.png"),
    Categories(name: "Cat", image: "assets/images/cat_asset.jpg"),
    Categories(name: "Dog", image: "assets/images/dog_asset.png"),
    Categories(name: "Cat", image: "assets/images/cat_asset.jpg"),
    Categories(name: "Dog", image: "assets/images/dog_asset.png"),
    Categories(name: "Cat", image: "assets/images/cat_asset.jpg"),
    Categories(name: "Dog", image: "assets/images/dog_asset.png"),
  ];

  static String cat = "assets/images/cat_asset.jpg";
}
