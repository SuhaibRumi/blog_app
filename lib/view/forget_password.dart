import 'package:blog_app/widgets/reuseable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({super.key});

  @override
  State<RestPassword> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rest Password'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        Image.asset(
          "assets/images/forgotpassword.png",
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // TextField for email..//
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Enter Your Email",
                  prefixIcon: Icon(Icons.mail),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'User name connot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              RoundedButton(
                  title: "Rest Password",
                  onTap: () {
                    _auth
                        .sendPasswordResetEmail(email: _emailController.text)
                        .onError((error, stackTrace) {
                      print('Error');
                    }).then(
                      (value) => Navigator.of(context).pop(),
                    );
                  }),
            ],
          ),
        )
      ]),
    );
  }
}
