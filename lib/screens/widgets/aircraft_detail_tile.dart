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

      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),


      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),


      decoration: BoxDecoration(

        color: Colors.white.withValues(
          alpha: 0.18,
        ),


        borderRadius:
            BorderRadius.circular(18),


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


          Icon(

            icon,

            color: const Color(0xFF2F80ED),

            size: 24,

          ),



          const SizedBox(
            width: 16,
          ),



          Expanded(

            child: Text(

              title,


              style: const TextStyle(

                fontSize: 13,

                fontWeight:
                    FontWeight.w600,

                letterSpacing: 1,


                color: Color(0xFF7A8CA5),

              ),

            ),

          ),



          Container(

            width: 1,

            height: 28,


            color: Colors.white.withValues(
              alpha: 0.5,
            ),

          ),



          const SizedBox(
            width: 18,
          ),



          Expanded(

            child: Text(

              value,


              textAlign:
                  TextAlign.end,


              style: const TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.w700,


                color: Color(0xFF0F172A),

              ),

            ),

          ),


        ],

      ),

    );

  }

}