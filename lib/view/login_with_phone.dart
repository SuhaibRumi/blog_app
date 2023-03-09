import 'package:blog_app/view/verify_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/toster messgae/toster.dart';
import '../widgets/reuseable_button.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Login With Phone"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                    hintText: "+92 300 2343 432",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 80),
            RoundedButton(
                title: 'Send OTP code',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                    phoneNumber: phoneNumberController.text.toString(),
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      Utils().tosterMessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerifyCodeScreen(
                            verificationId: verificationId,
                          ),
                        ),
                      );

                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().tosterMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
