
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> uploadData(blogData) async {
  await  FirebaseFirestore.instance.collection('blogs').add(blogData).catchError((e){
      print(e);
    });

  }


