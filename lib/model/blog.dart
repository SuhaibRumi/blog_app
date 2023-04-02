import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String? id;
  final String? title;
  final String? desc;
  final DateTime? date;
  final bool? isDone;

  Blog({this.id, this.title, this.desc, this.date, this.isDone});

  factory Blog.fromMap(DocumentSnapshot map) {
     bool isDone = false;
    if (map['isDone'] == 1 || map['isDone'] == true) {
      isDone = true;
    }
    return Blog(
      id: map.id,
      title: map['title'],
      desc: map['desc'],
       isDone: isDone,
      date: DateTime.fromMillisecondsSinceEpoch(map['blog']),
    );
  }
  toMap() {
    Map<String, dynamic> row = {};

    //YYYY-MM-DD
    row = {
  
      'title': title,
      'desc': desc,
       'isDone': isDone,

      'date': date!.millisecondsSinceEpoch,
    };

    return row;
  }
}

class BlogList {
  final List<Blog> blogList;
  BlogList({required this.blogList});
  factory BlogList.fromJson(List<dynamic> data) {
    List<Blog> blogTasks = [];
    blogTasks = data.map((i) => Blog.fromMap(i)).toList();
    return BlogList(blogList: blogTasks);
  }
}
