import 'package:flutter/material.dart';

class PetsGridWidget extends StatelessWidget {
  PetsGridWidget({
    super.key,
    required this.title,
    required this.price,
    required this.place,
    required this.contact,
  });

  String? title;
  String? price;
  String? place;
  String? contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.grey,
        // image: DecorationImage(
        //   image: AssetImage(""),
        // ),
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
    );
  }
}
