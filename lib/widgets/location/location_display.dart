import 'package:flutter/material.dart';


class LocationDisplay extends StatelessWidget {

  final String city;

  final String country;


  const LocationDisplay({

    super.key,

    required this.city,

    required this.country,

  });



  @override
  Widget build(BuildContext context) {


    return Column(

      mainAxisSize: MainAxisSize.min,


      children: [


        Text(

          city,


          style: const TextStyle(

            fontSize: 16,

            fontWeight: FontWeight.w200,

            letterSpacing: 0.5,

            color: Color(0xFF5C8DFF),

          ),

        ),




        const SizedBox(

          height: 2,

        ),




        Text(

          country,


          style: const TextStyle(

            fontSize: 12,

            fontWeight: FontWeight.w300,

            letterSpacing: 1.5,

            color: Color(0xFF8AAEFF),

          ),

        ),


      ],


    );


  }


}