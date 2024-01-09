import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paws_app/view/pets_details_screen/pets_details_screen.dart';

class PetsGridWidget extends StatelessWidget {
  PetsGridWidget({
    super.key,
    required this.isFavorite,
    required this.pets,
  });

  bool isFavorite;
  dynamic pets;

  CollectionReference petsGrid =
      FirebaseFirestore.instance.collection('petsCollection');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetsDetailsScreen(
              isFavorite: isFavorite,
              pets: pets,
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.orange,
                    // image: DecorationImage(
                    //   image: NetworkImage(widget.image),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: pets['image'],
                    fit: BoxFit.cover,
                    // width: double.infinity,
                    placeholder: (context, url) => Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: Colors.red[400],
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                            pets['title'],
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Text(
                            pets['price'],
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Text(
                            pets['place'],
                            maxLines: 1,
                          ),
                          SizedBox(height: 5),
                          Text(
                            pets['contact'],
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
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                print(pets.id);
                petsGrid.doc(pets.id).update({
                  'favorite': isFavorite == false ? true : false,
                });
              },
              icon: isFavorite == false
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
