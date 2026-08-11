import 'dart:math' as math;
import 'package:flutter/material.dart';


class ContrailPainter extends CustomPainter {

  final double progress;


  const ContrailPainter({
    required this.progress,
  });



  @override
  void paint(Canvas canvas, Size size) {

    if (progress <= 0) return;


    final centerY = size.height / 2;


    // DOUBLE LENGTH PREMIUM TAIL
    final length =
        size.width * progress * 10.0;



    // ==========================
    // SOFT BLUE VOLUME
    // ==========================

    final Paint cloudPaint = Paint()
      ..color = const Color(0xFF8FC5FF)
          .withValues(alpha: 0.22)

      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        14,
      );



    for(
      double d = 0;
      d < length;
      d += 12
    ){

      final x =
          size.width - d;


      final fade =
          (1 - d / length)
          .clamp(0.03, 1.0);



      final spread =
          math.sin(d * 0.09) * 3;



      final y =
          centerY + spread;



      canvas.drawCircle(

        Offset(
          x,
          y,
        ),

        30 * fade,

        cloudPaint,

      );


    }




    // ==========================
    // HARD PREMIUM CORE
    // ==========================


    final Path path = Path();


    path.moveTo(
      size.width,
      centerY,
    );



    for(
      double x = size.width;
      x > size.width - length;
      x -= 4
    ){

      final distance =
          size.width - x;



      final wave =
          math.sin(distance * 0.09) * 1.4;



      path.lineTo(
        x,
        centerY + wave,
      );

    }




    final Paint corePaint = Paint()

      ..shader = LinearGradient(

        begin: Alignment.centerRight,

        end: Alignment.centerLeft,


        colors: [

          const Color(0xFFF2FAFF)
              .withValues(alpha:0.85),


          const Color(0xFF8FC5FF)
              .withValues(alpha:0.55),


          Colors.transparent,

        ],


      ).createShader(

        Rect.fromLTWH(
          0,
          centerY - 8,
          size.width,
          16,
        ),

      )


      ..strokeWidth = 6.0
    

      ..strokeCap = StrokeCap.round

      ..style = PaintingStyle.stroke;



    canvas.drawPath(
      path,
      corePaint,
    );






    // ==========================
    // DISSOLVE PARTICLES
    // ==========================


    final Paint particlePaint = Paint()

      ..color = const Color(0xFF9CCBFF)
          .withValues(alpha:0.30);



    for(
      double d = 20;
      d < length;
      d += 9
    ){

      final fade =
          (1 - d / length)
          .clamp(0.0, 1.0);



      final x =
          size.width - d;



      final y =
          centerY +
          math.sin(d * 0.25) * 6;



      canvas.drawCircle(

        Offset(
          x,
          y,
        ),

        2.5 * fade,

        particlePaint,

      );

    }

  }




  @override
  bool shouldRepaint(
    covariant ContrailPainter oldDelegate,
  ){

    return oldDelegate.progress != progress;

  }

}