import 'package:flutter/material.dart';


class AircraftDetailTile extends StatelessWidget {

  final IconData icon;
  final String title;
  final String value;


  const AircraftDetailTile({

    super.key,

    required this.icon,

    required this.title,

    required this.value,

  });


  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.only(
        bottom: 16,
      ),


      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),


      decoration: BoxDecoration(

        color: Colors.white.withValues(
          alpha: 0.20,
        ),


        borderRadius: BorderRadius.circular(22),


        border: Border.all(

          color: Colors.white.withValues(
            alpha: 0.45,
          ),

          width: 1,

        ),

      ),



      child: Row(

        children: [


          Container(

            width: 34,

            height: 34,


            decoration: BoxDecoration(

              shape: BoxShape.circle,


              color: const Color(0xFFEAF3FF),

            ),


            child: Icon(

              icon,

              size: 18,

              color: const Color(0xFF2F80ED),

            ),

          ),



          const SizedBox(width: 18),



          Expanded(

            child: Text(

              title,


              style: const TextStyle(

                fontSize: 12,

                fontWeight: FontWeight.w600,

                letterSpacing: 1.2,

                color: Color(0xFF6E88B5),

              ),

            ),

          ),



          Text(

            value,


            style: const TextStyle(

              fontSize: 18,

              fontWeight: FontWeight.w700,

              letterSpacing: 0.3,

              color: Color(0xFF294C7A),

            ),

          ),


        ],

      ),

    );

  }

}