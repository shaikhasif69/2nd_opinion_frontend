import 'dart:io';

import 'package:doctor_opinion/models/doctor/degrees.dart';
import 'package:doctor_opinion/provider/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustoDropDown extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CustomDropDown();
    throw UnimplementedError();
  }
}

class _CustomDropDown extends ConsumerState<CustoDropDown> {
  Widget build(context) {
    List<String> data = ref.watch(DropDownProvider);

    ;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (contex, index) {
            return DropDownWidgetextend(
                title: data[index],
                data: medicalDegreesAndSpecializations[data[index]]!);
          }),
    );
  }
}

class DropDownWidgetextend extends StatefulWidget {
  const DropDownWidgetextend({required this.title, required this.data});
  final String title;
  final List<String> data;
  @override
  State<StatefulWidget> createState() {
    return _DropDownWidgetextend(data: data);
    throw UnimplementedError();
  }
}

class _DropDownWidgetextend extends State<DropDownWidgetextend> {
  _DropDownWidgetextend({required this.data});
  List<String> data;
  bool visible = false;

  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (visible) {
                          visible = false;
                        } else {
                          visible = true;
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down))
              ],
            ),
          ),
          visible
              ? AnimatedContainer(
                  height: 300,
                  duration: Duration(microseconds: 100),
                  child: ListView.builder(
                      itemCount: widget.data.length,
                      itemBuilder: (context, index2) {
                        return Specialization(
                            mainTitle: widget.title,
                            subTitle: widget.data[index2]);
                      }),
                )
              : SizedBox(),
          const Divider()
        ],
      ),
    );
  }
}

class Specialization extends StatefulWidget {
  const Specialization({required this.mainTitle, required this.subTitle});
  final String mainTitle;
  final String subTitle;
  @override
  State<StatefulWidget> createState() {
    return _Specialization();
    throw UnimplementedError();
  }
}

class _Specialization extends State<Specialization> {
  bool selected = false;
  bool checkIfContaineKeyVale() {
    if (selectedMedicalDegreesAndSpecializations
        .containsKey(widget.mainTitle)) {
      for (Map<String, File?> x
          in selectedMedicalDegreesAndSpecializations[widget.mainTitle]!) {
        if (x.keys.first == widget.subTitle) {
          return true;
        }
      }
    }
    return false;
  }

  Widget build(context) {
    bool seleted = checkIfContaineKeyVale();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: seleted
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Container(
                  // color:
                  //     seleted ? Theme.of(context).colorScheme.secondary : null,
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.subTitle),
              )),
              const Spacer(),
              seleted
                  ? IconButton(
                      onPressed: () {
                        int i = 0;

                        for (var x in selectedMedicalDegreesAndSpecializations[
                            widget.mainTitle]!) {
                          if (x.keys.first == widget.subTitle) {
                            break;
                          }
                          i++;
                        }
                        selectedMedicalDegreesAndSpecializations[
                                widget.mainTitle]!
                            .removeAt(i);

                        if (selectedMedicalDegreesAndSpecializations[
                                widget.mainTitle]!
                            .isEmpty) {
                          selectedMedicalDegreesAndSpecializations
                              .remove(widget.mainTitle);
                        }

                        setState(() {});
                      },
                      icon: Icon(Icons.close))
                  : IconButton(
                      onPressed: () {
                        if (selectedMedicalDegreesAndSpecializations
                            .containsKey(widget.mainTitle)) {
                          selectedMedicalDegreesAndSpecializations[
                                  widget.mainTitle]!
                              .add({widget.subTitle: null});
                        } else {
                          selectedMedicalDegreesAndSpecializations[
                              widget.mainTitle] = [
                            {widget.subTitle: null}
                          ];
                        }
                        setState(() {});
                      },
                      icon: Icon(Icons.add))
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
