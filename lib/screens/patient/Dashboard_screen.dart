import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:doctor_opinion/provider/doctor_state.dart';
import 'package:doctor_opinion/provider/fetchDoctorsProvider.dart';
import 'package:doctor_opinion/router/NamedRoutes.dart';
import 'package:doctor_opinion/screens/patient/doctorRecomendationCorousel.dart';
import 'package:doctor_opinion/screens/patient/topDoctorCard.dart';
import 'package:doctor_opinion/screens/views/articlePage.dart';
import 'package:doctor_opinion/screens/views/doctor_details_screen.dart';
import 'package:doctor_opinion/screens/views/doctor_search.dart';
import 'package:doctor_opinion/widgets/article.dart';
import 'package:doctor_opinion/widgets/banner.dart';
import 'package:doctor_opinion/widgets/listIcons.dart';
import 'package:doctor_opinion/widgets/list_doctor1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Dashboard extends ConsumerStatefulWidget {
  Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   ref.read(doctorProvider.notifier).fetchAvailableDoctors("10:00");
    //   ref.read(doctorProvider.notifier).fetchTopRatedDoctors();
    // });

    Future.microtask(() {
      final doctorNotifier = ref.read(doctorProvider.notifier);
      final doctorState = ref.read(doctorProvider);

      if (doctorState.topRatedDoctors == null ||
          doctorState.topRatedDoctors!.isEmpty) {
        doctorNotifier.fetchTopRatedDoctors();
      }

      if (doctorState.availableDoctors == null ||
          doctorState.availableDoctors!.isEmpty) {
        doctorNotifier.fetchAvailableDoctors("10:00");
      }
    });
  }

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    final doctorState = ref.watch(doctorProvider);

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
          const SizedBox(
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
          _sectionHeader("Available Doctors", onTap: () {
            // Navigate to the full list of available doctors
          }),
          _doctorList(doctorState, doctorType: "available"),
          SizedBox(
            height: 10,
          ),
          BannerCarousel(),
          const SizedBox(
            height: 20,
          ),
          _sectionHeader("Top Doctors", onTap: () {
            // Navigate to the full list of top-rated doctors
          }),
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Container(
          //     height: 190,
          //     width: MediaQuery.of(context).size.width * 1,
          //     child: ListView(
          //       physics: BouncingScrollPhysics(),
          //       scrollDirection: Axis.horizontal,
          //       children: [
          //         list_doctor1(
          //             distance: "130m Away",
          //             image: "lib/icons/male-doctor.png",
          //             maintext: "Dr. Marcus Horizon",
          //             numRating: "4.7",
          //             subtext: "Chardiologist"),
          //         list_doctor1(
          //             distance: "130m Away",
          //             image: "lib/icons/docto3.png",
          //             maintext: "Dr. Maria Elena",
          //             numRating: "4.6",
          //             subtext: "Psychologist"),
          //         list_doctor1(
          //             distance: "2km away",
          //             image: "lib/icons/doctor2.png",
          //             maintext: "Dr. Stevi Jessi",
          //             numRating: "4.8",
          //             subtext: "Orthopedist"),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20,),
          //   Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //   child: Container(
          //     height: 160,
          //     width: MediaQuery.of(context).size.width * 1,
          //     child: ListView(
          //       physics: BouncingScrollPhysics(),
          //       scrollDirection: Axis.horizontal,
          //       children: [
          //         // TopDoctorCard(
          //         //     distance: "130m Away",
          //         //     image: "lib/icons/male-doctor.png",
          //         //     maintext: "Dr. Marcus Horizon",
          //         //     numRating: "4.7",
          //         //     subtext: "Chardiologist"),
          //         // TopDoctorCard(
          //         //     distance: "130m Away",
          //         //     image: "lib/icons/docto3.png",
          //         //     maintext: "Dr. Maria Elena",
          //         //     numRating: "4.6",
          //         //     subtext: "Psychologist"),
          //         // TopDoctorCard(
          //         //     distance: "2km away",
          //         //     image: "lib/icons/doctor2.png",
          //         //     maintext: "Dr. Stevi Jessi",
          //         //     numRating: "4.8",
          //         //     subtext: "Orthopedist"),
          //       ],
          //     ),
          //   ),
          // ),
          _doctorList(doctorState, doctorType: "top"),
          const SizedBox(
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
          const SizedBox(
            height: 10,
          ),
          SizedBox(
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
        ]),
      ),
    );
  }

  Widget _sectionHeader(String title, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 46, 46, 46),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "See all",
              style: GoogleFonts.inter(
                fontSize: 16,
                color: const Color.fromARGB(255, 3, 190, 150),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doctorList(DoctorState doctorState, {required String doctorType}) {
    if (doctorState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (doctorState.error != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          "Error: ${doctorState.error}",
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    List<dynamic> doctors = [];
    if (doctorType == "available") {
      doctors = doctorState.availableDoctors ?? [];
    } else if (doctorType == "top") {
      doctors = doctorState.topRatedDoctors ?? [];
    }

    if (doctors.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          "No $doctorType doctors found.",
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: SizedBox(
        height: 190, // Adjust height based on your design
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctors[index];
            return GestureDetector(
              onTap: () {
                GoRouter.of(context).pushNamed(
                  PatientRoutes.doctorProfile,
                  extra: doctor,
                );
              },
              child: doctorType == "top"
                  ? TopDoctorCard(doctor: doctor)
                  : list_doctor1(doctor: doctor),
            );
          },
        ),
      ),
    );
  }
}
