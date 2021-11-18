// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogapp/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

FirebaseStorage storage = FirebaseStorage.instance;
String? url;
bool isLoading1 = false;

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  TextEditingController blogTitle = TextEditingController();
  TextEditingController authorName = TextEditingController();
  TextEditingController description = TextEditingController();

  File? image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final selectedImage = File(image!.path);
    setState(() {
      this.image = selectedImage;
    });
  }

  Future uploadImage() async {
    Reference reference =
        storage.ref().child('images').child("${randomAlphaNumeric(9)}.jpg");
    UploadTask uploadTask = reference.putFile(image!);

    TaskSnapshot taskSnapshot = await uploadTask;
    url = await taskSnapshot.ref.getDownloadURL();
    print('URLLLLLLLLL$url');

    Map<String, dynamic> blogData = {
      "imageurl": url,
      "title": blogTitle.text,
      "authorName": authorName.text,
      "description": description.text,
    };
    if (image != null) {
      uploadData(blogData);
      Navigator.pop(context);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              uploadImage();
              // uploadData();
              setState(() {
                isLoading1 = true;
                print("$blogTitle + $authorName + $description");
              });
            },
            icon: Icon(
              Icons.upload_sharp,
            ),
          ),
        ],
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
      body: isLoading1
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: image != null
                            ? Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    )),
                              )
                            : Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  Icons.add_a_photo_sharp,
                                  color: Colors.black87,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: 'Add title here...'),
                        controller: blogTitle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: authorName,
                        decoration: InputDecoration(
                            hintText: 'Add Author name here...'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        maxLines: 5,
                        controller: description,
                        decoration: InputDecoration(
                            hintText: 'Add Description here...'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
