import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NEWS/res/colors.dart';
import 'package:NEWS/utils/routes/routes_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RoutesName.home);
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/splash_pic.jpg', fit: BoxFit.cover, height: height*.5,),
          SizedBox(
            height: height*.05,
          ),
          Text("TOP HEADLINES", style: GoogleFonts.anton(letterSpacing: .6, color: Colors.grey[700]),),
          SizedBox(
            height: height*.05,
          ),
          const SpinKitChasingDots(
            color: AppColors.accentColor,
            size: 40,
          )
        ]
      )
    );
  }
}
