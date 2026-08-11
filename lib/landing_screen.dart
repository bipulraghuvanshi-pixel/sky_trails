import 'package:flutter/material.dart';

import 'main.dart';
import 'widgets/animated_plane.dart';
import 'widgets/notification/notification_button.dart';
import 'widgets/location/location_display.dart';
import 'widgets/sky/sky_background.dart';


class LandingScreen extends StatefulWidget {

  const LandingScreen({
    super.key,
  });


  @override
  State<LandingScreen> createState() =>
      _LandingScreenState();

}



class _LandingScreenState extends State<LandingScreen> {


  bool showSearch = false;



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: SkyBackground(

        child: Stack(

          children: [



            Center(

              child: Column(

                mainAxisSize:
                    MainAxisSize.min,


                children: [



                  GestureDetector(

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const SkyTrailsApp(),

                        ),

                      );

                    },


                    child: Stack(

                      alignment:
                          Alignment.center,


                      children: [



                        Container(

                          width: 230,

                          height: 120,


                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,


                            boxShadow: [

                              BoxShadow(

                                color: const Color(0xFF5C8DFF)
                                    .withValues(
                                      alpha: 0.12,
                                    ),

                                blurRadius: 60,

                                spreadRadius: 20,

                              ),

                            ],

                          ),

                        ),



                        Image.asset(

                          'assets/images/sky_trails_logo.png',

                          width: 320,

                        ),



                      ],

                    ),

                  ),



                  const SizedBox(

                    height: 5,

                  ),




                  SizedBox(

                    width: 320,

                    height: 180,



                    child: Stack(

                      alignment:
                          Alignment.centerLeft,


                      children: [



                        AnimatedOpacity(

                          opacity: showSearch
                              ? 1.0
                              : 0.0,


                          duration:
                              const Duration(
                                milliseconds: 1400,
                              ),


                          curve:
                              Curves.easeOutCubic,



                          child: AnimatedSlide(

                            offset: showSearch

                                ? Offset.zero

                                : const Offset(
                                    0,
                                    0.15,
                                  ),


                            duration:
                                const Duration(
                                  milliseconds: 1400,
                                ),


                            curve:
                                Curves.easeOutCubic,



                            child: Container(

                              width: 310,

                              height: 52,


                             decoration:
    BoxDecoration(

  color: Colors.white.withValues(
    alpha: 0.28,
  ),


  borderRadius:
      BorderRadius.circular(30),


  border: Border.all(

    color: Colors.white.withValues(
      alpha: 0.20,
    ),

    width: 1,

  ),


  boxShadow: [

    BoxShadow(

  color: const Color(0xFF5C8DFF)
      .withValues(
        alpha: 0.04,
      ),

  blurRadius: 30,

  spreadRadius: 2,

  offset: const Offset(
    0,
    8,
  ),

),

  ],

),



                              child: TextField(

                                textAlign:
                                    TextAlign.center,


                                decoration:
                                    InputDecoration(

                                  hintText:
                                      'Search aircraft',


                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                        vertical: 18,
                                      ),



                                  hintStyle:
                                      const TextStyle(

                                    color:
                                        Color(0xFF5C8DFF),

                                    fontSize: 17,

                                    fontWeight:
                                        FontWeight.w300,

                                    letterSpacing:
                                        0.4,

                                  ),



                                  border:
                                      InputBorder.none,

                                ),

                              ),

                            ),

                          ),

                        ),




                        Positioned(

                          left: 50,

                          top: 52,


                          child: AnimatedPlane(

                            onTap: () {


                              Future.delayed(

                                const Duration(
                                  milliseconds: 1500,
                                ),

                                () {

                                  if (!mounted) return;


                                  setState(() {

                                    showSearch = true;

                                  });

                                },

                              );


                            },


                          ),

                        ),



                      ],

                    ),

                  ),



                ],

              ),

            ),





            Positioned(

              top: 50,

              right: 24,


              child: NotificationButton(

                onTap: () {

                  debugPrint(
                    "Notification tapped",
                  );

                },

              ),

            ),





            Positioned(

              bottom: 40,

              left: 0,

              right: 0,


              child: LocationDisplay(

                city: "Bilaspur",

                country: "India",

              ),

            ),



          ],

        ),

      ),

    );


  }

}