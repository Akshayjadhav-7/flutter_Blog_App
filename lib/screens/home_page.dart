// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/screens/create_blog.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutter',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              Text(
                'Blog',
                style: TextStyle(fontSize: 22, color: Colors.blue),
              )
            ],
          ),
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(left: 36, bottom: 16),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateBlog()),
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ]),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return BlogTile(
                        authorName: snapshot.data!.docs[index]['authorName'],
                        title: data['title'],
                        description: data['description'],
                        url: data['imageurl']);
                  });
            }));
  }
}

class BlogTile extends StatelessWidget {
  String? authorName, title, description, url;

  BlogTile(
      {required this.authorName,
      required this.title,
      required this.description,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black87.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  title!,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Author - ${authorName!}",
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 3,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: description!,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
