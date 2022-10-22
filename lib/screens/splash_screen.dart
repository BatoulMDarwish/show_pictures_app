import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:show_pictures/layout/home_layout.dart';
import 'package:show_pictures/shared/style/color.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
        ()=>Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context){
          return  const HomeLayout();
        }
        ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children:  [
            const Center(
              child:
              Text(
                'Unsplash',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 40,
                ),
              ),
            ),
            Positioned(
            bottom: 30,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/gallery.png'),
            )
          ],
        ),
      ),
    );
  }
}
