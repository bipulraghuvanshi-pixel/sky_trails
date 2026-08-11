import 'package:flutter/material.dart';


class NotificationButton extends StatelessWidget {

  final VoidCallback? onTap;


  const NotificationButton({
    super.key,
    this.onTap,
  });



  @override
  Widget build(BuildContext context) {


    return GestureDetector(

      onTap: onTap,


      child: Container(

        width: 48,

        height: 48,


        decoration: BoxDecoration(

          color: Colors.white.withValues(
            alpha: 0.72,
          ),


          shape: BoxShape.circle,


          border: Border.all(

            color: Colors.white
                .withValues(alpha: 0.8),

            width: 1,

          ),


          boxShadow: [

            BoxShadow(

              color: Colors.black
                  .withValues(alpha: 0.06),

              blurRadius: 24,

              offset: const Offset(
                0,
                10,
              ),

            ),


            BoxShadow(

              color: const Color(0xFF5C8DFF)
                  .withValues(alpha: 0.08),

              blurRadius: 20,

            ),

          ],

        ),



        child: const Icon(

          Icons.notifications_none_rounded,

          size: 23,

          color: Color(0xFF4E7DFF),

        ),

      ),

    );

  }

}