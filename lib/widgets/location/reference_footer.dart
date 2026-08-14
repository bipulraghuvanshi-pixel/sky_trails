import 'package:flutter/material.dart';
import '../../services/location_service.dart';

class ReferenceFooter extends StatelessWidget {

  final LocationData? location;

  const ReferenceFooter({
    super.key,
    required this.location,
  });


  @override
  Widget build(BuildContext context) {

    if (location == null) {
      return const SizedBox();
    }


    return Column(

      children: [

        const SizedBox(
          height: 120,
        ),


        Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(

              Icons.location_on,

              size: 15,

              color: const Color(0xFF5C8DFF)
                  .withValues(
                    alpha: 0.45,
                  ),

            ),


            const SizedBox(
              width: 5,
            ),


            Text(

              "${location!.city}, ${location!.country}",

              style: TextStyle(

                fontSize: 15,

                fontWeight: FontWeight.w500,

                letterSpacing: 0.3,

                color: const Color(0xFF5C8DFF)
                    .withValues(
                      alpha: 0.45,
                    ),

              ),

            ),

          ],

        ),



        const SizedBox(
          height: 6,
        ),



        Text(

          "${location!.latitude.toStringAsFixed(4)}° N, "
          "${location!.longitude.toStringAsFixed(4)}° E",


          style: TextStyle(

            fontSize: 12,

            letterSpacing: 0.5,

            fontWeight: FontWeight.w300,

            color: const Color(0xFF8AAEFF)
                .withValues(
                  alpha: 0.35,
                ),

          ),

        ),



        const SizedBox(
          height: 30,
        ),


      ],

    );

  }

}