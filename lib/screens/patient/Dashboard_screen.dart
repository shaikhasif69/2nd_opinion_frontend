import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/screens/patient/doctorRecomendationCorousel.dart';
import 'package:doctor_opinion/screens/patient/topDoctorCard.dart';
import 'package:doctor_opinion/screens/views/articlePage.dart';
import 'package:doctor_opinion/screens/views/doctor_search.dart';
import 'package:doctor_opinion/widgets/article.dart';
import 'package:doctor_opinion/widgets/banner.dart';
import 'package:doctor_opinion/widgets/listIcons.dart';
import 'package:doctor_opinion/widgets/list_doctor1.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Dashboard extends StatelessWidget {
   Dashboard({super.key});



final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.065,
            width: MediaQuery.of(context).size.width * 0.06,
            child: GestureDetector(
              onTap: () {
                print("hellooo");
                GoRouter.of(context).pushNamed(PatientRoutes.searchSection);
              },
              child: Icon(
                Icons.search,
                size: 28,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset(
                "lib/icons/bell.png",
                filterQuality: FilterQuality.high,
              ),
            ),
          )
        ],
        title: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "2nd Opinion\nThere, For YOU!",
              style: GoogleFonts.inter(
                  color: Color.fromARGB(255, 51, 47, 47),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ],
        ),
        toolbarHeight: 130,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(children: [
        RecomendDoctorCorousel(imgList: imgList),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(PatientRoutes.doctorProfile);
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.rightToLeft,
                    //         child: doctor_search()));
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              listIcons(Icon: "lib/icons/Doctor.png", text: "Doctor"),
              listIcons(Icon: "lib/icons/Pharmacy.png", text: "Pharmacy"),
              listIcons(Icon: "lib/icons/Hospital.png", text: "Hospital"),
              listIcons(Icon: "lib/icons/Ambulance.png", text: "Ambulance"),
            ],
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Doctors",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(PatientRoutes.doctorProfile);
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.rightToLeft,
                    //         child: doctor_search()));
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  TopDoctorCard(
                      distance: "130m Away",
                      image: "lib/icons/male-doctor.png",
                      maintext: "Dr. Marcus Horizon",
                      numRating: "4.7",
                      subtext: "Chardiologist"),
                  TopDoctorCard(
                      distance: "130m Away",
                      image: "lib/icons/docto3.png",
                      maintext: "Dr. Maria Elena",
                      numRating: "4.6",
                      subtext: "Psychologist"),
                  TopDoctorCard(
                      distance: "2km away",
                      image: "lib/icons/doctor2.png",
                      maintext: "Dr. Stevi Jessi",
                      numRating: "4.8",
                      subtext: "Orthopedist"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Health article",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: articlePage()));
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 1,
            height: 155,
            child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  article(
                image: "images/article1.png",
                dateText: "Jun 10, 2021 ",
                duration: "5min read",
                mainText:
                    "The 25 Healthiest Fruits You Can Eat,\nAccording to a Nutritionist"),
                    article(
                image: "images/article1.png",
                dateText: "Jun 10, 2021 ",
                duration: "5min read",
                mainText:
                    "The 25 Healthiest Fruits You Can Eat,\nAccording to a Nutritionist"),
                    article(
                image: "images/article1.png",
                dateText: "Jun 10, 2021 ",
                duration: "5min read",
                mainText:
                    "The 25 Healthiest Fruits You Can Eat,\nAccording to a Nutritionist"),
                ],

            ),
          ),
          SizedBox(
            height: 10,
          ),
           BannerCarousel(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Doctor",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // doctor_search
                    GoRouter.of(context).pushNamed(PatientRoutes.doctorProfile);
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.rightToLeft,
                    //         child: doctor_search()));
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 190,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  list_doctor1(
                      distance: "130m Away",
                      image: "lib/icons/male-doctor.png",
                      maintext: "Dr. Marcus Horizon",
                      numRating: "4.7",
                      subtext: "Chardiologist"),
                  list_doctor1(
                      distance: "130m Away",
                      image: "lib/icons/docto3.png",
                      maintext: "Dr. Maria Elena",
                      numRating: "4.6",
                      subtext: "Psychologist"),
                  list_doctor1(
                      distance: "2km away",
                      image: "lib/icons/doctor2.png",
                      maintext: "Dr. Stevi Jessi",
                      numRating: "4.8",
                      subtext: "Orthopedist"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          
        ]),
      ),
    );
  }
}
