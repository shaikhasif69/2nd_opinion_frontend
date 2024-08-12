import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RecomendDoctorCorousel extends StatefulWidget {
  final List<String> imgList;

  RecomendDoctorCorousel({required this.imgList});

  @override
  _RecomendDoctorCorouselState createState() => _RecomendDoctorCorouselState();
}

class _RecomendDoctorCorouselState extends State<RecomendDoctorCorousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .asMap()
        .entries
        .map((entry) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _current == entry.key
                      ? Color.fromARGB(255, 3, 190, 150)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: _current == entry.key ? 1.0 : 0.0,
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Doctor Name",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Specialty",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Looking for your Desire Specialist Doctor",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          entry.value,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();

    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
            autoPlayInterval: const Duration(seconds: 6),
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 2.7,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.map((url) {
            int index = widget.imgList.indexOf(url);
            return GestureDetector(
              onTap: () => _current = index,
              child: Container(
                // width: 8.0,
                // height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
