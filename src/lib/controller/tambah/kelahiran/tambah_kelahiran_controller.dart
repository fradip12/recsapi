import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/model/birth_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';
import 'package:uuid/uuid.dart';

class TambahKelahiranController extends GetxController {
  final MainController mainController = Get.find<MainController>();
  final Rx<TextEditingController> kelahiranKe = TextEditingController().obs;
  final Rx<TextEditingController> beratLahir = TextEditingController().obs;
  final _listKondisiKelahiran = BehaviorSubject<List<String>>.seeded(
      ["Mati", "Abortus", "Lemah", "Cacat", "Sehat"]);
  Stream<List<String>> get listKondisiKelahiran => _listKondisiKelahiran.stream;

  final _selectedKondisiKelahiran = BehaviorSubject<String?>.seeded(null);
  Sink<String?> get inselectedKondisiKelahiran =>
      _selectedKondisiKelahiran.sink;
  Stream<String?> get outselectedKondisiKelahiran =>
      _selectedKondisiKelahiran.stream;

  final _listProsesKelahiran = BehaviorSubject<List<String>>.seeded(
      ["Normal", "Dengan bantuan", "Terjadi prolapses"]);
  Stream<List<String>> get listProsesKelahiran => _listProsesKelahiran.stream;

  final _selectedProsesKelahiran = BehaviorSubject<String?>.seeded(null);
  Sink<String?> get inselectedProsesKelahiran => _selectedProsesKelahiran.sink;
  Stream<String?> get outselectedProsesKelahiran =>
      _selectedProsesKelahiran.stream;

  final _listJenisKelahiran = BehaviorSubject<List<String>>.seeded([
    "Tunggal Jantan",
    "Tunggal Betina",
    "Kembar Jantan-Jantan",
    "Kembar Jantan-Betina",
    "Kembar Betina-Betina"
  ]);
  Stream<List<String>> get listJenisKelahiran => _listJenisKelahiran.stream;

  final _selectedJenisKelahiran = BehaviorSubject<String?>.seeded(null);
  Sink<String?> get inselectedJenisKelahiran => _selectedJenisKelahiran.sink;
  Stream<String?> get outselectedJenisKelahiran =>
      _selectedJenisKelahiran.stream;

  Rx<String?> dateTime = ''.obs;

  late TambahKelahiranArguments args;

  @override
  void onInit() {
    print('initState: Tambah Kelahiran');
    super.onInit();
    args = Get.arguments as TambahKelahiranArguments;
  }

  Future<void> simpanKelahiran() async {
    var uuid = Uuid();

    var data = BirthModel();
    data.id = uuid.v5(Uuid.NAMESPACE_URL, (args.breedData.id! + uuid.v1()));
    data.numberOfBirth = int.tryParse(kelahiranKe.value.text);
    data.birthType = _selectedJenisKelahiran.value;
    data.birthWeight = beratLahir.value.text;
    data.birthdate = dateTime.value;
    data.breedingId = args.breedData.id;
    data.condition = _selectedKondisiKelahiran.value;
    data.process = _selectedProsesKelahiran.value;

    Logger().wtf(data.toJson());
    try {
      var res = await FireStore().submitBirth(mainController.user.value, data);
      if (res != null) {
        Get.back(result: true);
        Get.snackbar('Success', 'Berhasil Menambahkan Data');
      }
    } catch (e) {
      Get.back(result: false);
      Get.snackbar('Error', e.toString());
    }
  }
}
