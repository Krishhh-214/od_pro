/*
// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, duplicate_ignore, sized_box_for_whitespace, unnecessary_null_comparison, unused_local_variable, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:od_pro/widgets/custom_loading_dialog.dart';
import 'package:od_pro/utils/contant.dart';
import 'package:od_pro/views/addNewOrderScreen.dart';
import 'package:od_pro/views/loginScreen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // Debugging print statement to check user ID
    print('Current user ID: ${userId?.uid}');

    return Scaffold(
      appBar: AppBar(
        title: Text(AppContant.appName),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => AddNewOrderScreen());
              },
              child: CircleAvatar(
                radius: 15.0,
                child: Icon(Icons.add_business),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FadeInUp(
                duration: Duration(milliseconds: AppContant.animationDuration),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('newOrders')
                        .where('userId', isEqualTo: userId!.uid)
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      // Debugging print statement to log the connection state
                      print('StreamBuilder ConnectionState: ${snapshot.connectionState}');

                      if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 200.0),
                              child: Text("No Data Found!"),
                            ),
                          ],
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print('Loading data...');
                        return Container(
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        print('No documents found.');
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 200.0),
                              child: Text("No Data Found!"),
                            ),
                          ],
                        );
                      }
                      if (snapshot != null && snapshot.data != null) {
                        print('Number of documents: ${snapshot.data!.docs.length}');
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var orderStatus = snapshot.data!.docs[index]['status'].toString();
                            var docId = snapshot.data!.docs[index].id;
                            return Card(
                              child: ListTile(
                                title: Text(snapshot.data!.docs[index]['productName'].toString()),
                                subtitle: orderStatus == 'pending'
                                    ? Text(
                                  snapshot.data!.docs[index]['status'].toString(),
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                )
                                    : Text(
                                  snapshot.data!.docs[index]['status'].toString(),
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                leading: FadeInLeft(
                                  duration: Duration(milliseconds: AppContant.animationDuration),
                                  child: CircleAvatar(
                                    child: Text(
                                      index.toString(),
                                    ),
                                  ),
                                ),
                                trailing: FadeInRight(
                                  duration: Duration(milliseconds: AppContant.animationDuration),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.defaultDialog(
                                        title: "Mark as Sold?",
                                        content: Container(
                                          child: Text("Do you want to mark it as sold?"),
                                        ),
                                        onCancel: () async {},
                                        onConfirm: () async {
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection('newOrders')
                                                .doc(snapshot.data!.docs[index].id)
                                                .update({
                                              'status': "sold",
                                            });
                                            Get.back();
                                            print("sold");
                                          } on FirebaseAuthException catch (e) {
                                            print("Error: $e");
                                          }
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});


  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String userName = 'Your Name';
  String userEmail = 'your.email@example.com';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc['userName'] ?? 'No Name';
          userEmail = userDoc['userEmail'] ?? 'No Email';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : '',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(Icons.people),
            title: Text('Employees'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Attendance'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.summarize_outlined),
            title: Text('Summary'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Information'),
            onTap: () {},
          ),
          ExpansionTile(
            leading: Icon(Icons.workspaces_outline),
            title: Text('WORKSPACES'),
            children: <Widget>[
              ListTile(
                title: Text('Adstacks'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Finance'),
                onTap: () {},
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(() => LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
*/
