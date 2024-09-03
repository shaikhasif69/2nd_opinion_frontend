import 'package:doctor_opinion/models/hiveModels/doctor_hive.dart';
import 'package:doctor_opinion/models/hiveModels/user.dart';
import 'package:hive/hive.dart';

class HiveService {
  static const String userBoxName = 'userBox';
  static const String doctorBoxName = 'doctorBox';

  Future<void> saveUser(HiveUser user) async {
    var box = await Hive.openBox<HiveUser>(userBoxName);
    await box.put('currentUser', user);
  }

  Future<HiveUser?> getUser() async {
    var box = await Hive.openBox<HiveUser>(userBoxName);
    return box.get('currentUser');
  }

  Future<void> deleteUser() async {
    var box = await Hive.openBox<HiveUser>(userBoxName);
    await box.delete('currentUser');
  }

  Future<void> saveDcotr(DoctorHive doctor) async{
    var box = await Hive.openBox<DoctorHive>(doctorBoxName);
    await box.put('currentDoctor', doctor);
  }

    Future<DoctorHive?> getDoctor() async {
    var box = await Hive.openBox<DoctorHive>(doctorBoxName);
    return box.get('currentDoctor');
  }

  Future<void> deleteDoctor() async {
    var box = await Hive.openBox<DoctorHive>(doctorBoxName);
    await box.delete('currentDoctor');
  }


}
