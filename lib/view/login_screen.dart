import 'package:blog_app/view/forget_password.dart';
import 'package:blog_app/view/home_screen.dart';
import 'package:blog_app/view/login_with_phone.dart';
import 'package:blog_app/view/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/toster messgae/toster.dart';
import '../widgets/reuseable_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;

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

  void logIn() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }).onError((error, stackTrace) {
      Utils().tosterMessage(error.toString());

      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/login.png",
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formKey,
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
                            height: 20,
                          ),

                          // TextField for password..//
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    visibility();
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                hintText: "Enter Your Password",
                                prefixIcon: const Icon(Icons.lock)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password connot be empty';
                              } else if (value.length < 6) {
                                // return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const RestPassword()));
                                },
                                child: const Text("Forget Password ?",
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          ),

                          // reuseableButton//

                          RoundedButton(
                              title: 'Login',
                              loading: loading,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  logIn();
                                }
                              }),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Do you have not Account? "),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const SignUpScreen()));
                                },
                                child: const Text(
                                  "Sign Up ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          RichText(
                              text: const TextSpan(
                                  text: "Or",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ))),
                          const SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginWithPhone()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/call.png",
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Sign In With Phone Number",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            "Merriweather & Merriweather Sans"),
                                  ),
                                ],
                              )),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
