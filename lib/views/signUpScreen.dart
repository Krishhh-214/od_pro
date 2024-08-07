// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:od_pro/services/signUpService.dart';
import 'package:od_pro/utils/contant.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppContant.appName),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          // alignment: Alignment.center,
          child: Column(
            children: [
              FadeInDown(
                duration: Duration(milliseconds: AppContant.animationDuration),
                child: Container(
                  alignment: Alignment.center,
                  height: 250,
                  width: 300,
                  child: Lottie.asset(
                    'assets/images/welcome.json',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              FadeInLeft(
                duration: Duration(milliseconds: AppContant.animationDuration),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    maxLength: 30,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else if (RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Name cannot contain numbers';
                      }
                      return null;
                    },

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: userNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(

                      hintText: 'User name',
                      labelText: 'User name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FadeInLeft(
                duration: Duration(milliseconds: AppContant.animationDuration),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    maxLength: 50,
                    controller: userEmailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null; // Input is valid
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FadeInLeft(
                duration: Duration(milliseconds: AppContant.animationDuration),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    maxLength: 30,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter you password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(letterSpacing: 2),
                    controller: userPasswordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      suffixIconColor: Colors.redAccent,
                      hintText: 'Password',
                      labelText: 'Password',
                      suffixIcon: Icon(Icons.visibility_off),
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FadeInUp(
                duration: Duration(milliseconds: AppContant.animationDuration),
                child: ElevatedButton(
                  onPressed: () async {
                    if (userEmailController.text != '' &&
                        userEmailController.text != '' &&
                        userPasswordController.text != '') {
                      print("data Send to Service");
                      print(userEmailController.text);

                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: userEmailController.text.trim(),
                              password: userPasswordController.text.trim())
                          .then((value) {
                        UserSignUpService.UserSignUp(
                          context,
                          userNameController,
                          userEmailController,
                          userPasswordController,
                        );
                      });
                    } else {
                      print("Please enter details");
                    }
                  },
                  child: Text("SIGN UP"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: FadeInUp(
                  duration:
                      Duration(milliseconds: AppContant.animationDuration),
                  child: Container(
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
