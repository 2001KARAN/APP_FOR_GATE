import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gate/sub_topics.dart';

class module extends StatefulWidget {
  const module({Key? key}) : super(key: key);

  @override
  State<module> createState() => _moduleState();
}

class _moduleState extends State<module> {
  Future<List<dynamic>> getData() async {
    Map<String, List<dynamic>> a = {};
    List<List<dynamic>> links = [];
    // FirebaseFirestore.instance
    //     .collection('Module')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     // a[doc["m1"].toString()] =;
    //     print(doc.data());
    //   });
    // });

    // await FirebaseFirestore.instance
    //     .collection('Module')
    //     .doc('J798eNkIMWyI0lbfdx6O')
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   Map<String, dynamic> data =
    //       documentSnapshot.data() as Map<String, dynamic>;
    //   print(data['m1']);
    //   a[data['m1']] = data['sub_topics'];
    // });
    await FirebaseFirestore.instance
        .collection('Module')
        .get()
        .then((QuerySnapshot querysnapshot) => {
              querysnapshot.docs.forEach((element) {
                // print(element['m1']);
                // print(element['sub_topics']);
                Map<String, dynamic> data =
                    element.data() as Map<String, dynamic>;
                print(data);
                a[data['m1']] = data['sub_topics'];
                if (data.containsKey('links')) {
                  links.add(data['links']);
                }
              })
            });
    return [a, links];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.blueGrey,
              Colors.redAccent,
            ])),
        child: FutureBuilder<List<dynamic>>(
            future: getData(),
            builder: (context, snapshot) {
              print(snapshot.data?[0].keys.length);
              return Container(
                height: 800,
                child: ListView.builder(
                  itemCount: snapshot.data?[0].keys.length,
                  itemBuilder: ((context, index) => Card(
                        color: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // if you need this
                          side: BorderSide(
                            color: Color.fromRGBO(255, 160, 122, 1)
                                .withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        child: InkWell(
                          child: Card(
                            child: ListTile(
                              title: Text(
                                snapshot.data?[0].keys.elementAt(index) ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w200, fontSize: 20),
                              ),
                            ),
                          ),
                          onTap: () {
                            print(snapshot.data?[0].values.elementAt(index));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => subTopics(
                                      links: snapshot.data?[1][index],
                                      subtopics: snapshot.data?[0].values
                                              .elementAt(index) ??
                                          [])),
                            );
                          },
                        ),
                      )),
                  padding: EdgeInsets.all(10),
                ),
              );
            }),
      ),
    );
  }
}
