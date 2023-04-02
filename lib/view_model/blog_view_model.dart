import 'package:blog_app/model/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/firebase/firebase_utility.dart';

class BlogViewModel extends ChangeNotifier {
  String? id = "";
  String? title = "";
  String? desc = "";
   bool? isDone = false;
  DateTime? date = DateTime.now();


  BlogViewModel({
    this.id,
    this.title,
    this.date,
    this.desc,
    this.isDone,

  });

  factory BlogViewModel.fromMap(DocumentSnapshot map) {
    var blog = Blog.fromMap(map);
    return BlogViewModel(
        id: blog.id,
      title: blog.title,
      desc: blog.desc,
      date: blog.date,
      isDone: blog.isDone,
      
    );
  }
// for insert Data
  saveData() async {
    var blog = Blog(title: title, date: date,desc: desc,isDone: isDone);
    try {
      await FirebaseUtility.addData(collection: "blog", doc: blog.toMap());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

// for updeting
  update() async {
    try {
      var blog = Blog(title: title, date: date,desc: desc, isDone: isDone);
      await FirebaseUtility.updateData(
          collection: "blog", docId: id!, doc: blog.toMap());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  deleteData() async {
    
  }

  getData(bool blogStaus) {
    var data = FirebaseUtility.getBlog(status: blogStaus);
    notifyListeners();
    return data;
  }
}