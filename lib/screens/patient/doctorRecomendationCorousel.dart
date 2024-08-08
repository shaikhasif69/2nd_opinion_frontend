import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RecomendDoctorCorousel extends StatefulWidget {
  List<String> imgList;

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
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _current == entry.key
                      ? Color.fromARGB(255, 3, 190, 150)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: _current == entry.key ? 1.0 : 0.0,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, top: 10, bottom: 3),
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: _current == entry.key ? 90 : 50,
                                width: _current == entry.key ? 100 : 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(entry.value),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_current == entry.key)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Looking for your Desire Specialist Doctor",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                    ],
                  ),
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
            return const SizedBox();
          }).toList(),
        )
      ],
    );
  }
}
