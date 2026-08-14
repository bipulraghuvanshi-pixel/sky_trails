import 'package:flutter/material.dart';

import '../models/aircraft.dart';
import '../widgets/sky/sky_background.dart';
import 'widgets/aircraft_detail_tile.dart';


class AircraftDetailsPage extends StatelessWidget {

  final Aircraft plane;


  const AircraftDetailsPage({

    super.key,

    required this.plane,

  });



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBodyBehindAppBar: true,

      backgroundColor: Colors.transparent,


      appBar: AppBar(

        elevation: 0,

        backgroundColor: Colors.transparent,

        surfaceTintColor: Colors.transparent,


        iconTheme: const IconThemeData(

          color: Color(0xFF6FA8FF),

        ),


        title: const Text(

          'Aircraft Details',

          style: TextStyle(

            color: Color(0xFF294C7A),

            fontSize: 18,

            fontWeight: FontWeight.w600,

            letterSpacing: 0.2,

          ),

        ),

      ),



      body: SkyBackground(

        child: Column(

          children: [


            const SizedBox(height: 100),



            const Icon(

              Icons.flight,

              size: 40,

              color: Color(0xFF2F80ED),

            ),



            const SizedBox(height: 10),



            Text(

              plane.callsign,

              style: const TextStyle(

                fontSize: 34,

                fontWeight: FontWeight.w700,

                letterSpacing: 1.2,

                color: Color(0xFF294C7A),

              ),

            ),



            const SizedBox(height: 8),



            Row(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [


                const Icon(

                  Icons.public,

                  size: 15,

                  color: Color(0xFF5C8DFF),

                ),



                const SizedBox(width: 6),



                Text(

                  plane.country,

                  style: const TextStyle(

                    fontSize: 15,

                    fontWeight: FontWeight.w500,

                    letterSpacing: 0.3,

                    color: Color(0xFF6B7FA3),

                  ),

                ),


              ],

            ),



            const SizedBox(height: 28),



            Expanded(

              child: ListView(

                padding: const EdgeInsets.symmetric(

                  horizontal: 24,

                ),


                children: [


                  AircraftDetailTile(

                    icon: Icons.sell_outlined,

                    title: 'CALL SIGN',

                    value: plane.callsign,

                  ),



                  AircraftDetailTile(

                    icon: Icons.flag_outlined,

                    title: 'COUNTRY',

                    value: plane.country,

                  ),



                  AircraftDetailTile(

                    icon: Icons.flight_takeoff,

                    title: 'ALTITUDE',

                    value:

                        '${plane.altitude?.toStringAsFixed(0) ?? '--'} M',

                  ),



                  AircraftDetailTile(

                    icon: Icons.speed,

                    title: 'SPEED',

                    value:

                        '${plane.speed.toStringAsFixed(0)} KM/H',

                  ),



                  AircraftDetailTile(

                    icon: Icons.near_me_outlined,

                    title: 'DISTANCE',

                    value:

                        '${plane.distance.toStringAsFixed(1)} KM',

                  ),



                  AircraftDetailTile(

                    icon: Icons.location_on_outlined,

                    title: 'LATITUDE',

                    value:

                        plane.latitude.toStringAsFixed(4),

                  ),



                  AircraftDetailTile(

                    icon: Icons.public,

                    title: 'LONGITUDE',

                    value:

                        plane.longitude.toStringAsFixed(4),

                  ),



                  const SizedBox(height: 24),


                ],

              ),

            ),


          ],

        ),

      ),

    );

  }

}