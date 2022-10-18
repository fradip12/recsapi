import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/model/milk_model.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/services/firebase_auth.dart';
import 'package:src/controller/main_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class ProduksiSusuController extends GetxController {
  final MainController _mainController = Get.find<MainController>();
  late ProduksiSusuArguments args;

  final _cowData = BehaviorSubject<CowModel>();
  Stream<CowModel> get outCowData => _cowData.stream;

  final _milkList = BehaviorSubject<List<MilkModel>>();
  Stream<List<MilkModel>> get outMilkList => _milkList.stream;

  final _focusedDay = BehaviorSubject<DateTime>.seeded(DateTime.now());
  Sink<DateTime> get inFocusedDay => _focusedDay.sink;
  Stream<DateTime> get outFocusedDay => _focusedDay.stream;

  final _kToday = BehaviorSubject<DateTime>.seeded(DateTime.now());
  Stream<DateTime> get outKToday => _kToday.stream;

  final _kFirstDay =
      BehaviorSubject<DateTime>.seeded(DateTime.utc(2000, 10, 16));
  Stream<DateTime> get outKFirstDay => _kFirstDay.stream;

  final _kLastDay = BehaviorSubject<DateTime>.seeded(DateTime.utc(2030, 3, 14));
  Stream<DateTime> get outKLastDay => _kLastDay.stream;

  final _kEvents = BehaviorSubject<LinkedHashMap<DateTime, MilkModel>>();
  Stream<LinkedHashMap<DateTime, MilkModel>> get outKEvents => _kEvents.stream;

  final _selectedEvents = BehaviorSubject<MilkModel?>.seeded(null);
  Sink<MilkModel?> get inSelectedEvents => _selectedEvents.sink;
  Stream<MilkModel?> get outSelectedEvents => _selectedEvents.stream;

  final _selectedDay = BehaviorSubject<DateTime?>.seeded(null);
  Sink<DateTime?> get inSelectedDay => _selectedDay.sink;
  Stream<DateTime?> get outSelectedDay => _selectedDay.stream;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      args = Get.arguments as ProduksiSusuArguments;
      _cowData.add(args.cowData);
    }
    getListMilk();
  }

  Future<void> getListMilk() async {
    var res = await FireStore()
        .getListMilk(_mainController.user.value, _cowData.value.id!);
    _milkList.add(res);
    if (_milkList.hasValue) {
      for (var element in _milkList.value) {
        _kEvents.add(LinkedHashMap<DateTime, MilkModel>(
            equals: isSameDay,
            hashCode: (DateTime key) {
              return key.day * 1000000 + key.month * 10000 + key.year;
            })
          ..addAll({DateTime.parse(element.date!): element}));
      }
    }
  }

  List<MilkModel?> getEventsForDay(DateTime? day) {
    // Implementation example
    if (_kEvents.hasValue && _kEvents.value[day] != null) {
      return [_kEvents.value[day]!];
    } else {
      return [];
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay.value, selectedDay)) {
      _selectedDay.add(selectedDay);
      _focusedDay.add(focusedDay);
      _selectedEvents.add(getEventsForDay(selectedDay)
          .firstWhereOrNull((element) => element != null));
    }
  }
}
