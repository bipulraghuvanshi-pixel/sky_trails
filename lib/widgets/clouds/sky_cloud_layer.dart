import 'package:flutter/material.dart';


class SkyCloudLayer extends StatefulWidget {

  const SkyCloudLayer({
    super.key,
  });


  @override
  State<SkyCloudLayer> createState() =>
      _SkyCloudLayerState();

}



class _SkyCloudLayerState extends State<SkyCloudLayer>
    with SingleTickerProviderStateMixin {


  late AnimationController _controller;



  @override
  void initState() {

    super.initState();


    _controller = AnimationController(

      vsync: this,

      duration: const Duration(
        seconds: 45,
      ),

    )..repeat();

  }





  @override
  Widget build(BuildContext context) {


    return IgnorePointer(

      child: AnimatedBuilder(

        animation: _controller,


        builder: (context, child) {


          return Stack(

            children: [



              // Cloud 1 - Top Left (Visible)

              Positioned(

                top: 120,

                left: -120 +
                    (_controller.value * 200),


                child: _cloud(

                  width: 240,

                  opacity: 0.38,

                ),

              ),





              // Cloud 2 - Top Right (Faint)

              Positioned(

                top: 80,

                right: -130 +
                    (_controller.value * 120),


                child: _cloud(

                  width: 210,

                  opacity: 0.14,

                ),

              ),





              // Cloud 3 - Middle Right (Most Visible)

              Positioned(

                top: 300,

                right: -150 +
                    (_controller.value * 180),


                child: _cloud(

                  width: 300,

                  opacity: 0.28,

                ),

              ),





              // Cloud 4 - Bottom Left (Faint)

              Positioned(

                top: 570,

                left: -50 -
                    (_controller.value * 100),


                child: _cloud(

                  width: 190,

                  opacity: 0.12,

                ),

              ),





              // Cloud 5 - Bottom Right

              Positioned(

                top: 640,

                right: -100 +
                    (_controller.value * 130),


                child: _cloud(

                  width: 240,

                  opacity: 0.16,

                ),

              ),



            ],

          );


        },

      ),

    );

  }






  Widget _cloud({

    required double width,

    required double opacity,

  }) {


    return Container(

      width: width,


      height: width * 0.45,



      decoration: BoxDecoration(


        borderRadius:
            BorderRadius.circular(120),



        gradient: LinearGradient(


          begin: Alignment.topCenter,

          end: Alignment.bottomCenter,


          colors: [


            Colors.white.withValues(

              alpha: opacity,

            ),



            const Color(0xFFCFE3FF)
                .withValues(

                  alpha: opacity,

                ),



          ],


        ),




        boxShadow: [


          BoxShadow(

            color: const Color(0xFF8DB8FF)
                .withValues(

                  alpha: 0.08,

                ),

            blurRadius: 50,

            spreadRadius: 10,


          ),


        ],


      ),


    );


  }





  @override
  void dispose() {

    _controller.dispose();

    super.dispose();

  }

}