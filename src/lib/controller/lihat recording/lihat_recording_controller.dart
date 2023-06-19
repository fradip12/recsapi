import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';

class LihatRecordingController extends GetxController {
  final MainController mainController = Get.find<MainController>();
  final _menu = BehaviorSubject<List<String>>.seeded(
      ['Sapi', 'Pembiakan', 'Kelahiran', 'Susu']);
  Stream<List<String>> get menu => _menu.stream;

  String? filePath;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    filePath = '$path/data.csv';
    return File('$path/data.csv').create();
  }

  getSapi() async {
    List<List<dynamic>> rows = <List<dynamic>>[];
    var cloud = await FireStore().getSapi(mainController.user.value);
    rows.add([
      "Code",
      "name",
      "breed",
      "gender",
      "color",
      "birthdate",
      "parent_m",
      "parent_f",
      "strow_number",
      "notes",
      "weight_birth",
      "weight_4mo",
      "weight_1yo",
      "chest_circumference_1yo",
      "body_length_1yo",
      "gumba_height_1yo",
    ]);

    if (cloud.isNotEmpty) {
      for (int i = 0; i < cloud.length; i++) {
        List<dynamic> row = <dynamic>[];
        row.add(cloud[i].uniqueId);
        row.add(cloud[i].name);
        row.add(cloud[i].breed);
        row.add(cloud[i].gender == 0 ? 'Betina' : 'Jantan');
        row.add(cloud[i].color);
        row.add(cloud[i].birthdate);
        row.add(cloud[i].parentM);
        row.add(cloud[i].parentF);
        row.add(cloud[i].strowNumber);
        row.add(cloud[i].notes);
        row.add(cloud[i].weightBirth);
        row.add(cloud[i].weight4Mo);
        row.add(cloud[i].weight1Yo);
        row.add(cloud[i].chestCircumference1Yo);
        row.add(cloud[i].bodyLength1Yo);
        row.add(cloud[i].gumbaHeight1Yo);
        rows.add(row);
      }
      File f = await _localFile;
      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
      var res = await OpenFilex.open(f.path);
      if (res.message == 'done') {
        Get.snackbar('Success', 'Data berhasil di export');
      } else {
        Get.snackbar('Error', 'Anda Harus Menginstall Aplikasi Excel');
      }
    }
  }

  getBreeding() async {
    List<List<dynamic>> rows = <List<dynamic>>[];
    var cloud = await FireStore().getAllBreeding(mainController.user.value);
    rows.add([
      "id",
      "cow_id",
      "strow_number",
      "male_id",
      "male_name",
      "sc",
      "breed_date",
      "pregnant_state",
    ]);

    if (cloud.isNotEmpty) {
      for (int i = 0; i < cloud.length; i++) {
        List<dynamic> row = <dynamic>[];
        row.add(cloud[i].id);
        row.add(cloud[i].cowId);
        row.add(cloud[i].strowNumber);
        row.add(cloud[i].maleId);
        row.add(cloud[i].maleName);
        row.add(cloud[i].sc);
        row.add(cloud[i].breedDate);
        row.add(cloud[i].pregnantState);
        rows.add(row);
      }
      File f = await _localFile;
      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
      var res = await OpenFilex.open(f.path);
      if (res.message == 'done') {
        Get.snackbar('Success', 'Data berhasil di export');
      } else {
        Get.snackbar('Error', 'Anda Harus Menginstall Aplikasi Excel');
      }
    }
  }

  getBirth() async {
    List<List<dynamic>> rows = <List<dynamic>>[];
    var cloud = await FireStore().getAllBirth(mainController.user.value);
    rows.add([
      "id",
      "breeding_id",
      "number_of_birth",
      "condition",
      "process",
      "birthdate",
      "birth_type",
      "birth_weight",
    ]);

    if (cloud.isNotEmpty) {
      for (int i = 0; i < cloud.length; i++) {
        List<dynamic> row = <dynamic>[];
        row.add(cloud[i].id);
        row.add(cloud[i].breedingId);
        row.add(cloud[i].numberOfBirth);
        row.add(cloud[i].condition);
        row.add(cloud[i].process);
        row.add(cloud[i].birthdate);
        row.add(cloud[i].birthType);
        row.add(cloud[i].birthWeight);
        rows.add(row);
      }
      File f = await _localFile;
      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
      var res = await OpenFilex.open(f.path);
      if (res.message == 'done') {
        Get.snackbar('Success', 'Data berhasil di export');
      } else {
        Get.snackbar('Error', 'Anda Harus Menginstall Aplikasi Excel');
      }
    }
  }

  getMilk() async {
    List<List<dynamic>> rows = <List<dynamic>>[];
    var cloud = await FireStore().getAllMilk(mainController.user.value);
    rows.add([
      "id",
      "cow_id",
      "morning_milk",
      "afternoon_milk",
      "n_birth",
      "n_day",
      "date",
    ]);

    if (cloud.isNotEmpty) {
      for (int i = 0; i < cloud.length; i++) {
        List<dynamic> row = <dynamic>[];
        row.add(cloud[i].id);
        row.add(cloud[i].cowId);
        row.add(cloud[i].morningMilk);
        row.add(cloud[i].afternoonMilk);
        row.add(cloud[i].nBirth);
        row.add(cloud[i].nDay);
        row.add(cloud[i].date);
        rows.add(row);
      }
      File f = await _localFile;
      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
      var res = await OpenFilex.open(f.path);
      if (res.message == 'done') {
        Get.snackbar('Success', 'Data berhasil di export');
      } else {
        Get.snackbar('Error', 'Anda Harus Menginstall Aplikasi Excel');
      }
    }
  }
}
