import 'package:blog_app/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/toster messgae/toster.dart';
import '../widgets/reuseable_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verifyCodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: TextFormField(
                controller: verifyCodeController,
                decoration: const InputDecoration(hintText: "6 Digits Number"),
                keyboardType: TextInputType.number,
              ),
            ),
            RoundedButton(
                title: 'Verify',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verifyCodeController.text.toString());

                  try {
                    await auth.signInWithCredential(credential);  
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().tosterMessage(e.toString());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
