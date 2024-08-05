import 'package:doctor_opinion/router/NamedRoutes.dart';
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
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
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
          ),
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
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.9,
             decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 241, 234, 234),
          ),
              child: TextField(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       PageTransition(
                //           type: PageTransitionType.rightToLeft,
                //           child: find_doctor()));
                // },
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.none,
                autofocus: false,
                obscureText: false,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusColor: Colors.black26,
                  fillColor: Colors.transparent,
                  filled: true,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      height: 10,
                      width: 10,
                      child: Image.asset(
                        "lib/icons/search.png",
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  prefixIconColor: const Color.fromARGB(255, 3, 190, 150),
                  label: Text("Search doctor, drugs, articles..."),
                  enabledBorder: InputBorder.none,

                  floatingLabelBehavior: FloatingLabelBehavior.never,
             
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
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
          SizedBox(
            height: 10,
          ),
          const banner(),
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
          article(
              image: "images/article1.png",
              dateText: "Jun 10, 2021 ",
              duration: "5min read",
              mainText:
                  "The 25 Healthiest Fruits You Can Eat,\nAccording to a Nutritionist"),
        ]),
      ),
    );
  }
}
