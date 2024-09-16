//This class will read OTP coming from firebase

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Otpscreen extends StatefulWidget {
  String verificationId;
  Otpscreen({super.key, required this.verificationId});

  @override
  State<Otpscreen> createState() {
    return _OtpscreenState();
  }
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otp Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Enter the OTP",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                PhoneAuthCredential credential =
                    await PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: otpController.text.toString());

                FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: "MyhomePage")));
                });
              } catch (ex) {
                log(ex.toString());
              }
            },
            child: Text("OTP Show"),
          )
        ],
      ),
    );
  }

  MyHomePage({required String title}) {}
}
