import 'package:src/common/model/breeding_model.dart';
import 'package:src/common/model/sapi_model.dart';

class HomeMenu {
  final String? title;
  final String? route;
  final String? icon;

  HomeMenu({this.title, this.route, this.icon});
}

class DetailSapiArguments {
  final CowModel? sapi;

  DetailSapiArguments(this.sapi);
}

class PembiakanDetailArguments {
  final String cowId;

  PembiakanDetailArguments(this.cowId);
}

class KelahiranPagesArguments {
  final BreedingModel breedData;

  KelahiranPagesArguments(this.breedData);
}

class TambahKelahiranArguments {
  final BreedingModel breedData;

  TambahKelahiranArguments(this.breedData);
}
