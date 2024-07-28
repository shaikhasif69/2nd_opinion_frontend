import 'package:doctor_opinion/models/doctor/degrees.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropDownNotifier extends StateNotifier<List<String>> {
  DropDownNotifier() : super([]);

  void searchDegreeMethod(String str) {
    state = searchDegree(str);
  }
}

final DropDownProvider = StateNotifierProvider<DropDownNotifier, List<String>>(
    (ref) => DropDownNotifier());
  // onChanged: (v) {
  //                   print("v is");
  //                   print(v);
  //                   setState(() {
  //                     if (v.isEmpty || v == "") {
  //                       search = false;
  //                     } else {
  //                       search = true;
  //                     }
  //                   });
  //                   ref
  //                       .read(DropDownProvider.notifier)
  //                       .searchDegreeMethod(v.toUpperCase());
  //                   // ref.refresh(DropDownProvider);
  //                 }