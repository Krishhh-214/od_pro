// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, duplicate_ignore, sized_box_for_whitespace, unnecessary_null_comparison, unused_local_variable, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:od_pro/views/employeeListScreen.dart';
import 'package:od_pro/widgets/custom_loading_dialog.dart';
import 'package:od_pro/utils/contant.dart';

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
        title: Text('Home',textAlign: TextAlign.start,),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.message_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.power_settings_new_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person,),
            onPressed: () {},
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.purple[100],
              child: ListTile(
                title: Text('Top Rating Project'),
                subtitle: Text('Trending project and high rating project created by team.'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: Text('Learn More'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(

              color: Color.fromARGB(255, 11, 113, 136),
              
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('All Projects'),
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.cyan,
                    child: ListTile(
                      leading: Image.asset("assets/images/dating-app.png"),
                      title: Text('Technology behind the Blockchain'),

                        trailing: Icon(Icons.edit),
                      subtitle: Text('Project #1 - See project details'),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.cyan,
                    child: ListTile(
                      leading: Image.asset("assets/images/dating-app.png"),
                      title: Text('Technology behind the Blockchain'),trailing: Icon(Icons.edit),
                      subtitle: Text('Project #1 - See project details'),
                    ),
                  ),
                  
                  Card(
                    elevation: 10,
                    color: Colors.cyan,
                    child: ListTile(
                      leading: Image.asset("assets/images/dating-app.png"),
                      title: Text('Technology behind the Blockchain'),trailing: Icon(Icons.edit),
                      subtitle: Text('Project #1 - See project details'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.orange[100],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Top Creators'),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text('maddison_c21'),
                    subtitle: Text('Artworks: 9821'),
                  ),
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text('karl_wil802'),
                    subtitle: Text('Artworks: 7032'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.green[100],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Over All Performance'),
                    subtitle: Text('Pending vs Done'),
                  ),
                  // You would use a chart widget here (e.g., LineChart from fl_chart)
                ],
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.pink[100],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Center(child: Text('Today Birthday',style: TextStyle(fontSize: 20),)),
                  ),
                  ListTile(
                    leading: Icon(Icons.cake),
                    title: Text('2 Birthdays Today'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Birthday Wishing',style: TextStyle(fontSize: 15),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.purple[100],
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Anniversary'),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('3 Anniversaries Today'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Anniversary Wishing'),
                  ),
                ],
              ),
            ),
          ],
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
            onTap: () {
              Get.to(()=>EmployeeListScreen());
            },
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
