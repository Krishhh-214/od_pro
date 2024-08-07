

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:od_pro/utils/contant.dart';
import 'package:od_pro/views/employeeListScreen.dart';
import 'package:od_pro/widgets/custom_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class AddNewEmployeeScreen extends StatefulWidget {
  const AddNewEmployeeScreen({super.key});

  @override
  State<AddNewEmployeeScreen> createState() => _AddNewEmployeeScreenState();
}

class _AddNewEmployeeScreenState extends State<AddNewEmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  DateTime _joiningDate = DateTime.now();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Employee"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FadeInLeft(
          duration: Duration(milliseconds: AppContant.animationDuration),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: "Age",
                    labelText: "Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: mobileController,
                  decoration: InputDecoration(
                    hintText: "Mobile",
                    labelText: "Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Address",
                    labelText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: positionController,
                  decoration: InputDecoration(
                    hintText: "Position",
                    labelText: "Position",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  margin: EdgeInsets.only(left: 12.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Joining Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5.0),
                SizedBox(
                  height: 80,
                  child: ScrollDatePicker(
                    selectedDate: _joiningDate,
                    locale: Locale('en'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        _joiningDate = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15.0),
                FadeInUp(
                  duration: Duration(milliseconds: AppContant.animationDuration),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text != '' &&
                          ageController.text != '' &&
                          mobileController.text != '' &&
                          addressController.text != '' &&
                          positionController.text != '') {

                        //Map into database
                        Map<String, dynamic> newEmployeeMap = {
                          'userId': userId!.uid,
                          'name': nameController.text.trim(),
                          'age': ageController.text.trim(),
                          'mobile': mobileController.text.trim(),
                          'address': addressController.text.trim(),
                          'position': positionController.text.trim(),
                          'joiningDate': _joiningDate,
                          'createdAt': DateTime.now(),
                        };
                        // showDialog(
                        //     barrierDismissible: false,
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return CustomLoadingDialog(message: "Please Wait..");
                        //     });

                        //Add Data into Firebase
                        await FirebaseFirestore.instance
                            .collection('employees')
                            .doc()
                            .set(newEmployeeMap);
                        print("Employee Added Successfully");
                        Get.off(()=>EmployeeListScreen());
                      } else {
                        print("Please Fill All Details");
                        Get.back();
                      }
                    },
                    child: Text("Add"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
