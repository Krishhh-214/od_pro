
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:od_pro/views/homeScreen1.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Size mq;

  @override
  void initState() {
    super.initState();

    // Delaying the navigation to the HomeScreen for 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      // Setting the system UI to be edge-to-edge with transparent status bar
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
      // Navigating to the HomeScreen and removing the SplashScreen from the stack
      Get.offAll(() => const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('assets/images/icon_launcher.png'),
          ),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Text.rich(
              TextSpan(
                text: 'Hi It\'s me Krishna ',
                style: TextStyle(color: Colors.black87, fontSize: 16),
                children: [
                  TextSpan(
                    text: '❤️',
                    style: TextStyle(color: Colors.red),
                  ),
                  TextSpan(
                    text: '!',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
