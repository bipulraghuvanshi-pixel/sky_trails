import 'package:flutter/material.dart';


class ErrorCard extends StatelessWidget {

  final String title;
  final String message;

  final IconData icon;


  const ErrorCard({

    super.key,

    required this.title,

    required this.message,

    this.icon = Icons.cloud_off_rounded,

  });



  @override
  Widget build(BuildContext context) {


    return Container(

      margin: const EdgeInsets.symmetric(

        horizontal: 20,

        vertical: 16,

      ),


      padding: const EdgeInsets.all(24),



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

            width: 52,

            height: 52,


            decoration: BoxDecoration(


              shape:

                  BoxShape.circle,


              color: Colors.white.withValues(

                alpha: 0.35,

              ),

            ),



            child: Icon(

              icon,

              size: 28,

              color: const Color(0xFF5C8DFF),

            ),



          ),




          const SizedBox(

            height: 14,

          ),




          Text(

            title,


            style: const TextStyle(

              fontSize: 17,


              fontWeight:

                  FontWeight.w700,


              color:

                  Color(0xFF294C7A),

            ),


          ),




          const SizedBox(

            height: 6,

          ),




          Text(

            message,


            textAlign:

                TextAlign.center,



            style: const TextStyle(

              fontSize: 13,


              color:

                  Color(0xFF5F7394),

            ),


          ),



        ],

      ),

    );

  }

}