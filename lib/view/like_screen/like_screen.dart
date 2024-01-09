import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  CollectionReference petsGrid =
      FirebaseFirestore.instance.collection('petsCollection');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: petsGrid.where('favorite', isEqualTo: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot pets = snapshot.data!.docs[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Container(
                      height: 100,
                      width: MediaQuery.sizeOf(context).width * 95,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              pets['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                pets['title'],
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                              Text(
                                pets['price'],
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                              Text(
                                pets['place'],
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No value found"),
              );
            }
          }),
    );
  }
}
