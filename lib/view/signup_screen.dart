import 'package:blog_app/view/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../utils/toster messgae/toster.dart';
import '../widgets/reuseable_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  void visibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void signUp() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      setState(() {
        loading = false;
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LogInScreen()));
    }).onError((error, stackTrace) {
      Utils().tosterMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/signup.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: "Enter Your Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                          height: 20,
                        ),
                        // TextField for password..//
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  visibility();
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              hintText: "Enter Your Password",
                              prefixIcon: const Icon(Icons.lock)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password connot be empty';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // reuseableButton//

                        RoundedButton(
                            title: 'Sign Up',
                            loading: loading,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                signUp();
                              }
                            }),
                      ],
                    )),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do you have already Account "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LogInScreen()));
                      },
                      child: const Text(
                        "LogIn",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
