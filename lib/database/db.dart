import 'package:paws_app/model/pets_model.dart';

class DataBase {
  List<PetsModel> petsList = [
    PetsModel(
        title: "dog", price: "1000", place: "thrissur", contact: "7852845"),
    PetsModel(
        title: "cat", price: "2000", place: "malappuram", contact: "7852845"),
    PetsModel(
        title: "fish", price: "300", place: "ernakulam", contact: "7852845"),
    PetsModel(
        title: "bird", price: "2500", place: "wayanad", contact: "7852845"),
  ];
}
