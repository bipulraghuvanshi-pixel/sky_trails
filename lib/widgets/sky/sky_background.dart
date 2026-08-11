import 'package:flutter/material.dart';
import '../clouds/sky_cloud_layer.dart';


class SkyBackground extends StatelessWidget {

  final Widget child;


  const SkyBackground({

    super.key,

    required this.child,

  });



  @override
  Widget build(BuildContext context) {


    return Stack(

      fit: StackFit.expand,


      children: [


        Container(

          decoration: const BoxDecoration(

            gradient: LinearGradient(

              begin: Alignment.topCenter,

              end: Alignment.bottomCenter,


              stops: [

                0.0,
                0.30,
                0.65,
                1.0,

              ],


              colors: [

                Color(0xFFFFFFFF),

                Color(0xFFF1F8FF),

                Color(0xFFDCEEFF),

                Color(0xFFC8E2FF),

              ],

            ),

          ),

        ),



        const SkyCloudLayer(),



        child,


      ],

    );

  }

}