import 'package:flutter/material.dart';
import 'animation/contrail_painter.dart';


class AnimatedPlane extends StatefulWidget {

  final VoidCallback? onTap;

  const AnimatedPlane({
    super.key,
    this.onTap,
  });


  @override
  State<AnimatedPlane> createState() => _AnimatedPlaneState();

}



class _AnimatedPlaneState extends State<AnimatedPlane>
    with TickerProviderStateMixin {


  late AnimationController _floatController;
  late Animation<double> _floatAnimation;


  late AnimationController _flightController;
  late Animation<double> _flightAnimation;
  late Animation<double> _rotationAnimation;


  bool isFlying = false;



  @override
  void initState() {
    super.initState();


    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);



    _floatAnimation = Tween<double>(
      begin: -4,
      end: 4,
    ).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOut,
      ),
    );



    _flightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    );



    _flightAnimation = Tween<double>(
      begin: 0,
      end: 600,
    ).animate(
      CurvedAnimation(
        parent: _flightController,
        curve: Curves.easeOutCubic,
      ),
    );



    _rotationAnimation = Tween<double>(
      begin: 0,
      end: -0.08,
    ).animate(
      CurvedAnimation(
        parent: _flightController,
        curve: Curves.easeOut,
      ),
    );

  }



  void takeOff(){

    if(isFlying) return;


    setState(() {
      isFlying = true;
    });


    _flightController.forward();


    widget.onTap?.call();

  }



  @override
  Widget build(BuildContext context) {


    return GestureDetector(

      onTap: takeOff,


      child: AnimatedBuilder(

        animation: Listenable.merge([
          _floatAnimation,
          _flightController,
        ]),


        builder: (context, child){


          final double x =
    isFlying ? _flightAnimation.value : 0;


final double y =
    isFlying ? 0 : _floatAnimation.value;



          final double rotation =
              isFlying ? _rotationAnimation.value : 0;



          return Transform.translate(

            offset: Offset(
              x,
              y,
            ),


            child: Stack(

              clipBehavior: Clip.none,


              alignment: Alignment.center,


              children: [


                if(isFlying)

  Positioned(
    left: -120,
    top: 18,

    child: SizedBox(
      width: 140,
      height: 24,

      child: CustomPaint(
        painter: ContrailPainter(
          progress: _flightController.value,
        ),
      ),
    ),
  ),



                Transform.rotate(

                  angle: rotation + 1.5708,


                  child: child,

                ),


              ],

            ),

          );


        },


        child: const Icon(

          Icons.airplanemode_active,

          size: 52,

          color: Color(0xFF5C8DFF),

        ),

      ),

    );

  }




  @override
  void dispose(){

    _floatController.dispose();

    _flightController.dispose();


    super.dispose();

  }

}