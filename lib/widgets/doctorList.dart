import 'package:doctor_opinion/models/doctor/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class doctorList extends StatelessWidget {
DoctorClass doctor;

  doctorList(
      {required this.doctor,
});

var specialty = "";
  @override
  Widget build(BuildContext context) {
    if(doctor.specialty.isEmpty){
      specialty = "No speciality";
    }
    else{
      specialty = doctor.specialty.first;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1400,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromARGB(255, 226, 226, 226)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              //Doctor image Container
              Container(
                height: MediaQuery.of(context).size.height * 0.1200,
                width: MediaQuery.of(context).size.width * 0.2400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(doctor.profilePicture),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain)),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1200,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.firstName + " " + doctor.lastName,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      specialty,
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01500,
                          width: MediaQuery.of(context).size.width * 0.08,
                          color: Color.fromARGB(255, 240, 236, 236),
                          child: Row(children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.01500,
                              width: MediaQuery.of(context).size.width * 0.03,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "lib/icons/Star.png",
                                      ),
                                      filterQuality: FilterQuality.high)),
                            ),
                            Text(
                              doctor.ratings.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
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
                    Row(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.01500,
                        width: MediaQuery.of(context).size.width * 0.03,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "lib/icons/Location.png",
                              ),
                              filterQuality: FilterQuality.high),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "130m away",
                        style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Color.fromARGB(255, 133, 133, 133),
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
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
