import 'package:src/common/model/birth_model.dart';
import 'package:src/common/model/breeding_model.dart';
import 'package:src/common/model/milk_model.dart';
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
  final BirthModel? editData;
  TambahKelahiranArguments(this.breedData, {this.editData});
}

class ProduksiSusuArguments {
  final CowModel cowData;

  ProduksiSusuArguments(this.cowData);
}

class TambahProduksiSusuArguments {
  final CowModel cowData;
  final String selectedDay;
  final MilkModel? editData;
  TambahProduksiSusuArguments(this.cowData, this.selectedDay, {this.editData});
}
