import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TopDoctorCard extends StatelessWidget {
  final String image;
  final String maintext;
  final String subtext;
  final String numRating;
  final String distance;

  TopDoctorCard(
      {required this.distance,
      required this.image,
      required this.maintext,
      required this.numRating,
      required this.subtext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color.fromARGB(134, 228, 227, 227)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 8,
            // ),
            Row(
              children: [
                SizedBox(
                  height: 155,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          maintext,
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        //Sub text
                        Text(
                          subtext,
                          style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //Rating star container start from here!!
                        Row(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.01500,
                              // width: MediaQuery.of(context).size.width * 0.08,
                              color: Color.fromARGB(255, 240, 236, 236),
                              child: Row(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.01500,
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "lib/icons/Star.png",
                                          ),
                                          filterQuality: FilterQuality.high)),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.01500,
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "lib/icons/Star.png",
                                          ),
                                          filterQuality: FilterQuality.high)),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.01500,
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "lib/icons/Star.png",
                                          ),
                                          filterQuality: FilterQuality.high)),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.01500,
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "lib/icons/Star.png",
                                          ),
                                          filterQuality: FilterQuality.high)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  numRating,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Color.fromARGB(255, 4, 179, 120),
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Experience",
                          style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "8 Years",
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Patients",
                          style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "1.08K",
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover),
                      shape: BoxShape.circle),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
