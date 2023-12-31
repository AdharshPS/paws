import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paws_app/view/pets_details_screen/pets_details_screen.dart';

class SearchedPetsWidget extends StatelessWidget {
  SearchedPetsWidget({super.key, required this.title});

  String? title;

  @override
  Widget build(BuildContext context) {
    CollectionReference petsGrid =
        FirebaseFirestore.instance.collection('petsCollection');
    return Scaffold(
      body: StreamBuilder(
          stream: petsGrid.where('title', isEqualTo: title).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 290,
                  ),
                  itemBuilder: (context, index) {
                    DocumentSnapshot searchPets = snapshot.data!.docs[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetsDetailsScreen(
                              isFavorite: searchPets['favorite'],
                              pets: searchPets,
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
                                    imageUrl: searchPets['image'],
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
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
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
                                      width: MediaQuery.of(context).size.width *
                                          40,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            searchPets['title'],
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            searchPets['price'],
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            searchPets['place'],
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            searchPets['contact'],
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
                                print(searchPets.id);
                                petsGrid.doc(searchPets.id).update({
                                  'favorite': searchPets['favorite'] == false
                                      ? true
                                      : false,
                                });
                              },
                              icon: searchPets['favorite'] == false
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
                  });
            } else {
              return Center(
                child: Text("No value found"),
              );
            }
          }),
    );
  }
}
