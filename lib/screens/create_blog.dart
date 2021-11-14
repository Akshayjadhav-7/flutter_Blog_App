// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {

   TextEditingController blogTitle = TextEditingController();
   TextEditingController authorName = TextEditingController();
   TextEditingController description = TextEditingController();

   final ImagePicker _picker = ImagePicker();

   Future getImage()async{
     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

     // setState(() {
     //   image = selectedImage;
     // });
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
               Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                      onPressed: () {
                        getImage();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.black87,
                      )),
                ),SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Add title here...'
                  ),
                 controller: blogTitle,
                ),SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: authorName,
                  decoration: InputDecoration(
                    hintText: 'Add Author name here...'
                ),),SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: 'Add Description here...'
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
