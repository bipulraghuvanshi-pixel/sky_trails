import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'aircraft_details_page.dart';
import '../models/aircraft.dart';
import '../widgets/sky/sky_background.dart';


class RadarPage extends StatefulWidget {

  final List<Aircraft> nearbyPlanes;
  final double userLat;
  final double userLon;


  const RadarPage({

    super.key,

    required this.nearbyPlanes,
    required this.userLat,
    required this.userLon,

  });


  @override
  State<RadarPage> createState() =>
      _RadarPageState();

}



class _RadarPageState extends State<RadarPage>
    with SingleTickerProviderStateMixin {


  late AnimationController _controller;



  @override
  void initState() {

    super.initState();


    _controller = AnimationController(

      vsync: this,

      duration: const Duration(
        seconds: 8,
      ),

    );


    _controller.forward();

  }



  @override
  void dispose() {

    _controller.dispose();

    super.dispose();

  }



  @override
  Widget build(BuildContext context) {


    final screenSize =
        MediaQuery.of(context).size;


    final centerX =
        screenSize.width / 2;


    final centerY =
        screenSize.height / 2;



    return Scaffold(

      extendBodyBehindAppBar: true,

      backgroundColor: Colors.transparent,


      appBar: AppBar(

        backgroundColor: Colors.transparent,

        surfaceTintColor: Colors.transparent,

        elevation: 0,

        scrolledUnderElevation: 0,


        iconTheme: const IconThemeData(

          color: Color(0xFF0F172A),

        ),


        title: Text(

          'Radar (${widget.nearbyPlanes.length})',

          style: const TextStyle(

            color: Color(0xFF0F172A),

            fontWeight: FontWeight.w600,

          ),

        ),

      ),



      body: SkyBackground(

        child: AnimatedBuilder(

          animation: _controller,


          builder: (context, child) {


            return Stack(

              alignment: Alignment.center,


              children: [



                ...widget.nearbyPlanes.map((plane) {


                  final double latDiff =
                      plane.latitude -
                      widget.userLat;


                  final double lonDiff =
                      plane.longitude -
                      widget.userLon;



                  final double baseTop =
                      centerY -
                      (latDiff * 40);



                  final double baseLeft =
                      centerX +
                      (lonDiff * 40);




                  final double progress =
                      Curves.easeOutCubic.transform(
                        _controller.value,
                      );



                  final double heading =
                      (plane.heading ?? 0) *
                      math.pi /
                      180;



                  final double glideX =
                      math.sin(heading) *
                      75 *
                      progress;



                  final double glideY =
                      -math.cos(heading) *
                      75 *
                      progress;



                  final double floatY =
                      math.sin(
                        _controller.value *
                        math.pi *
                        2,
                      ) *
                      3;




                  return Positioned(

                    top:
                        baseTop +
                        glideY +
                        floatY,


                    left:
                        baseLeft +
                        glideX,



                    child: InkWell(

                      onTap: () {


                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                AircraftDetailsPage(

                                  plane: plane,

                                ),

                          ),

                        );


                      },


                      child: Column(

                        mainAxisSize:
                            MainAxisSize.min,


                        children: [



                          Text(

                            plane.callsign,


                            style: const TextStyle(

                              color:
                                  Color(0xFF6FA8FF),

                              fontSize: 7,

                              fontWeight:
                                  FontWeight.w500,

                              letterSpacing: 0.4,

                            ),

                          ),





                          Container(

                            decoration: BoxDecoration(

                              boxShadow: [

                                BoxShadow(

                                  color:
                                      const Color(0xFF5C8DFF)
                                          .withValues(

                                            alpha: 0.35,

                                          ),

                                  blurRadius: 12,

                                  spreadRadius: 2,

                                ),

                              ],

                            ),



                            child: Transform.rotate(

                              angle: heading,


                              child: const Icon(

                                Icons.airplanemode_active,

                                color:
                                    Color(0xFF5C8DFF),

                                size: 22,

                              ),

                            ),

                          ),



                        ],

                      ),

                    ),

                  );


                }),





                // YOU LOCATION

                GestureDetector(

                  onTap: () {

                    _controller.forward(
                      from: 0,
                    );

                  },


                  child: Column(

                    mainAxisSize:
                        MainAxisSize.min,


                    children: [


                      const Text(

                        "YOU",

                        style: TextStyle(

                          color:
                              Color(0xFF6FA8FF),

                          fontSize: 7,

                          fontWeight:
                              FontWeight.w500,

                          letterSpacing: 0.4,

                        ),

                      ),



                      Container(

                        decoration: BoxDecoration(

                          boxShadow: [

                            BoxShadow(

                              color:
                                  const Color(0xFF5C8DFF)
                                      .withValues(

                                        alpha: 0.35,

                                      ),

                              blurRadius: 10,

                              spreadRadius: 1,

                            ),

                          ],

                        ),



                        child: const Icon(

                          Icons.location_on,

                          size: 22,

                          color:
                              Color(0xFF5C8DFF),

                        ),

                      ),


                    ],

                  ),

                ),



              ],

            );


          },

        ),

      ),

    );

  }

}