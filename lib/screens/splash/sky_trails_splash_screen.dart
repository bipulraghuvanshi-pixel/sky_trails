import 'package:flutter/material.dart';

import '../../landing_screen.dart';
import '../../widgets/clouds/sky_cloud_layer.dart';


class SkyTrailsSplashScreen extends StatefulWidget {

  const SkyTrailsSplashScreen({
    super.key,
  });


  @override
  State<SkyTrailsSplashScreen> createState() =>
      _SkyTrailsSplashScreenState();

}



class _SkyTrailsSplashScreenState 
    extends State<SkyTrailsSplashScreen> {


  @override
  void initState() {

    super.initState();


    Future.delayed(
      const Duration(milliseconds: 2100),
      () {

        if (!mounted) return;


        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const LandingScreen(),

          ),

        );

      },
    );

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xFFFFFFFF),

              Color(0xFFF4FAFF),

              Color(0xFFEAF5FF),

              Color(0xFFDDEEFF),

            ],

          ),

        ),



        child: SafeArea(

          child: Stack(

            children: [


              SkyCloudLayer(),



              Center(

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment.center,


                  children: [



                    Image.asset(

                      'assets/images/sky_trails_logo.png',

                      width: 300,

                    ),



                    const SizedBox(

                      height: 32,

                    ),



                    const Text(

                      "Reading the Sky...",

                      style: TextStyle(

                        fontSize: 22,

                        color: Color(0xFF5C8DFF),

                        letterSpacing: 0.6,

                        fontWeight:
                            FontWeight.w400,

                      ),

                    ),



                  ],

                ),

              ),


            ],

          ),

        ),

      ),

    );


  }

}