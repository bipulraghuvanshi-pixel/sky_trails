import 'package:flutter/material.dart';


class ActionCard extends StatelessWidget {

  const ActionCard({

    super.key,

    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,

  });


  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {


    return InkWell(

      borderRadius:
          BorderRadius.circular(18),


      onTap: onTap,


      child: Container(

        height: 74,


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

                    alpha: 0.08,

                  ),


              blurRadius: 25,


              offset: const Offset(

                0,

                10,

              ),

            ),

          ],


        ),



        child: Padding(

          padding:
              const EdgeInsets.symmetric(

                horizontal: 14,

              ),



          child: Row(


            mainAxisSize:
                MainAxisSize.min,


            children: [



              Container(

                width: 42,

                height: 42,


                decoration: BoxDecoration(


                  color: Colors.white.withValues(

                    alpha: 0.35,

                  ),



                  shape:
                      BoxShape.circle,



                  border: Border.all(

                    color: Colors.white.withValues(

                      alpha: 0.5,

                    ),

                  ),


                ),



                child: Icon(

                  icon,

                  size: 22,


                  color:
                      const Color(0xFF2F80ED),

                ),

              ),




              const SizedBox(

                width: 10,

              ),




              Flexible(

                fit: FlexFit.loose,


                child: Column(


                  mainAxisSize:
                      MainAxisSize.min,


                  mainAxisAlignment:
                      MainAxisAlignment.center,


                  crossAxisAlignment:
                      CrossAxisAlignment.start,



                  children: [



                    Text(

                      title,


                      maxLines: 1,


                      overflow:
                          TextOverflow.ellipsis,



                      style: const TextStyle(

                        fontSize: 16,

                        fontWeight:
                            FontWeight.w700,


                        color:
                            Color(0xFF0F172A),

                      ),

                    ),




                    const SizedBox(

                      height: 2,

                    ),




                    Text(

                      subtitle,


                      maxLines: 1,


                      overflow:
                          TextOverflow.ellipsis,



                      style: const TextStyle(

                        fontSize: 12,


                        color:
                            Color(0xFF64748B),

                      ),

                    ),



                  ],


                ),

              ),



            ],


          ),

        ),

      ),

    );


  }

}