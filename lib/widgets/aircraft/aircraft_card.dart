import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

import '../../models/aircraft.dart';
import '../../utils/country_code_helper.dart';


class AircraftCard extends StatelessWidget {

  const AircraftCard({

    super.key,

    required this.plane,

    required this.onTap,

  });


  final Aircraft plane;
  final VoidCallback onTap;



 


  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(22),

      onTap: onTap,


      child: Container(

        margin: const EdgeInsets.only(
          bottom: 16,
        ),


        padding: const EdgeInsets.all(16),


        decoration: BoxDecoration(

          color: Colors.white.withValues(
            alpha: 0.18,
          ),


          borderRadius:
              BorderRadius.circular(22),


          border: Border.all(

            color: Colors.white.withValues(
              alpha: 0.55,
            ),

            width: 1,

          ),


          boxShadow: [

            BoxShadow(

              color: const Color(0xFF5C8DFF)
                  .withValues(
                    alpha: 0.05,
                  ),

              blurRadius: 25,

              offset: const Offset(
                0,
                10,
              ),

            ),

          ],

        ),



        child: Row(

          children: [


            Container(

              width: 58,

              height: 58,


              decoration: BoxDecoration(

                color: Colors.white.withValues(
                  alpha: 0.35,
                ),

                shape: BoxShape.circle,


                border: Border.all(

                  color: Colors.white.withValues(
                    alpha: 0.5,
                  ),

                  width: 1,

                ),

              ),


              child: const Icon(

                Icons.flight,

                size: 32,

                color: Color(0xFF163D7A),

              ),

            ),



            const SizedBox(
              width: 18,
            ),



            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [


                  Text(

                    plane.callsign,


                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.w700,


                      color:
                          Color(0xFF294C7A),

                    ),

                  ),



                  const SizedBox(
                    height: 6,
                  ),



                  Row(

                    children: [


                      CountryFlag.fromCountryCode(
  CountryCodeHelper.getCode(
    plane.country,
  ),
  height: 16,
  width: 22,
),

const SizedBox(
  width: 6,
),



                      Expanded(

                        child: Text(

                          plane.country,


                          overflow:
                              TextOverflow.ellipsis,


                          style: const TextStyle(

                            fontSize: 15,

                            color:
                                Color(0xFF5F7394),

                          ),

                        ),

                      ),



                    ],

                  ),



                ],

              ),

            ),



            const SizedBox(
              width: 10,
            ),



            Container(

              padding:
                  const EdgeInsets.symmetric(

                    horizontal: 14,

                    vertical: 8,

                  ),


              decoration: BoxDecoration(


                color: Colors.white.withValues(

                  alpha: 0.25,

                ),



                borderRadius:
                    BorderRadius.circular(14),



                border: Border.all(

                  color: Colors.white.withValues(

                    alpha: 0.35,

                  ),

                ),


              ),



              child: Row(

                mainAxisSize:
                    MainAxisSize.min,


                children: [



                  const Icon(

  Icons.location_on,

  size: 15,

  color: Color(0xFF5C8DFF),

),



                  const SizedBox(
                    width: 4,
                  ),



                  Text(

                    "${plane.distance.toStringAsFixed(1)} km",


                    style: const TextStyle(

                      fontWeight:
                          FontWeight.w700,


                      color:
                          Color(0xFF2F80ED),

                    ),

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