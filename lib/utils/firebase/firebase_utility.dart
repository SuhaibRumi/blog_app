import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;

final postRef = FirebaseDatabase.instance.ref().child("Posts");

firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
