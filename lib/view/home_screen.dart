import 'package:blog_app/view/add_post_screen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'New Blog',
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddPostScreen()));
            },
            child: const Icon(
              Icons.add,
              size: 28,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
    
      ),
    );
  }
}
