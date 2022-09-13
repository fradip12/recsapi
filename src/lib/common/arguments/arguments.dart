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