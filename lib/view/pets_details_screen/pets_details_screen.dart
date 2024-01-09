import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PetsDetailsScreen extends StatefulWidget {
  PetsDetailsScreen({
    super.key,
    required this.isFavorite,
    required this.pets,
  });

  bool isFavorite;
  dynamic pets;

  State<PetsDetailsScreen> createState() => _PetsDetailsScreenState();
}

class _PetsDetailsScreenState extends State<PetsDetailsScreen> {
  CollectionReference petsGrid =
      FirebaseFirestore.instance.collection('petsCollection');
  @override
  build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: petsGrid.where(widget.pets.id).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 300,
                            child: PageView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) => Container(
                                width: MediaQuery.sizeOf(context).width,
                                child: Image.network(
                                  widget.pets['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              onPressed: () {
                                print(widget.pets.id);
                                petsGrid.doc(widget.pets.id).update({
                                  'favorite':
                                      widget.isFavorite == false ? true : false,
                                });
                              },
                              icon: widget.pets['favorite'] == false
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
                      SizedBox(height: 25),
                      Text(widget.pets['title']),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 5),
                          Text(widget.pets['place']),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(widget.pets['price']),
                          Text(" RS only"),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(widget.pets['contact']),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(""),
                );
              }
            }),
      ),
    );
  }
}
