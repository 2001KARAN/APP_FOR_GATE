import 'package:flutter/material.dart';
import 'package:gate/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class subTopics extends StatefulWidget {
  const subTopics({Key? key, required this.subtopics, required this.links})
      : super(key: key);
  final List<dynamic> subtopics;
  final List<dynamic> links;
  @override
  State<subTopics> createState() => _subTopicsState();
}

class _subTopicsState extends State<subTopics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
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
        child: Container(
          height: 800,
          child: ListView.builder(
            itemCount: widget.subtopics.length,
            itemBuilder: ((context, index) => Card(
                  color: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // if you need this
                    side: BorderSide(
                      color: Color.fromRGBO(255, 160, 122, 1).withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  child: InkWell(
                    child: Card(
                      child: ListTile(
                        title: Text(
                          widget.subtopics[index],
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 20),
                        ),
                      ),
                    ),
                    onTap: () {
                      print(widget.links[index]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Webview(
                                  link: widget.links[index],
                                )),
                      );
                    },
                  ),
                )),
            padding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
