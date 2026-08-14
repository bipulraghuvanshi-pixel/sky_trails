import 'package:flutter/material.dart';


class EmptySkyCard extends StatelessWidget {

  const EmptySkyCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {


    return Container(

      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),


      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 28,
      ),



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



      child: Column(

        mainAxisSize:
            MainAxisSize.min,


        children: [


          Container(

            width: 48,

            height: 48,


            decoration: BoxDecoration(

              shape:
                  BoxShape.circle,


              color: Colors.white.withValues(
                alpha: 0.35,
              ),

            ),



            child: const Icon(

              Icons.cloud_outlined,

              size: 28,

              color: Color(0xFF6FA8FF),

            ),

          ),



          const SizedBox(
            height: 14,
          ),



          const Text(

            "Sky is clear",

            style: TextStyle(

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



          const Text(

            "No aircraft nearby\nat this moment",

            textAlign:
                TextAlign.center,


            style: TextStyle(

              fontSize: 13,

              height: 1.4,

              color:
                  Color(0xFF6B7FA3),

            ),

          ),



        ],

      ),

    );

  }

}