import 'dart:io';

import 'package:blog_app/widgets/drawer.dart';
import 'package:blog_app/widgets/resuseable_textfield.dart';
import 'package:blog_app/widgets/reuseable_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image selected yet");
      }
    });
  }

  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image selected yet");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Uplod Blogs"),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  dialog(context);
                },
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * 1,
                    child: _image != null
                        ? ClipRect(
                            child: Image.file(
                              _image!.absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 100,
                            width: 100,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 40,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MyTextField(lableText: "Title", controller: titleController),
              const SizedBox(
                height: 30,
              ),
              MyTextField(lableText: "Description", controller: descController),
              const SizedBox(
                height: 70,
              ),
              RoundedButton(title: "Upload", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

// Function showDialog
  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: SizedBox(
              height: 130,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getCameraImage();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      getGalleryImage();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text("Gallery"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
