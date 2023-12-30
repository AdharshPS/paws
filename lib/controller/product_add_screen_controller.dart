import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paws_app/database/db.dart';
import 'package:paws_app/model/pets_model.dart';
import 'package:paws_app/view/bottom_navigator_screen/bottom_navigator_screen.dart';

class ProductAddScreenController with ChangeNotifier {
  int itemIndex = 0;
  bool isSelected = false;
  bool isSubmitOkay = false;

  ImagePicker picker = ImagePicker();

  bool selectedImage = false;

  selectCategory(int index) {
    itemIndex = index;
    isSelected = true;
    notifyListeners();
  }

  pickMultiimage(
      {required List<XFile?> pickedImageList,
      String? text1,
      String? text2,
      String? text3}) async {
    List<XFile?> images = await picker.pickMultiImage();
    pickedImageList.addAll(images);

    pickedImageList.isNotEmpty ? selectedImage = true : selectedImage = false;
    textfieldsValidation(text1!, text2!, text3!);

    notifyListeners();
  }

  pickCameraimage(
      {required List<XFile?> pickedImageList,
      String? text1,
      String? text2,
      String? text3}) async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    pickedImageList.add(image);
    pickedImageList.isNotEmpty ? selectedImage = true : selectedImage = false;
    textfieldsValidation(text1!, text2!, text3!);

    notifyListeners();
  }

  deletePickedImage(
      {required List<XFile?> pickedImageList,
      required int index,
      String? text1,
      String? text2,
      String? text3}) {
    pickedImageList.removeAt(index);
    pickedImageList.isNotEmpty ? selectedImage = true : selectedImage = false;
    textfieldsValidation(text1!, text2!, text3!);
    notifyListeners();
  }

  textfieldsValidation(String text1, String text2, String text3) {
    text1.isNotEmpty &&
            text2.isNotEmpty &&
            text3.isNotEmpty &&
            selectedImage == true
        ? isSubmitOkay = true
        : isSubmitOkay = false;

    notifyListeners();
  }

  submitFunction(
      {required List<XFile?> pickedImageList,
      required TextEditingController price,
      required TextEditingController location,
      required TextEditingController contact,
      required BuildContext context}) {
    if (isSubmitOkay == true) {
      DataBase.petsList.add(
        PetsModel(
          title: DataBase.categories[itemIndex].name,
          price: price.text,
          location: location.text,
          contact: contact.text,
          image: pickedImageList,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationBarScreen(),
        ),
      );

      isSelected = false;
      isSubmitOkay = false;
      selectedImage = false;
    } else {
      null;
    }
    notifyListeners();
  }
}
