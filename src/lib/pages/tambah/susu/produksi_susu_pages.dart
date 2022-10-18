import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/model/milk_model.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/controller/tambah/susu/produksi_susu_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/style/text_style.dart';

class ProduksiSusu extends StatefulWidget {
  const ProduksiSusu({Key? key}) : super(key: key);

  @override
  State<ProduksiSusu> createState() => _ProduksiSusuState();
}

class _ProduksiSusuState extends State<ProduksiSusu> {
  @override
  void initState() {
    super.initState();
  }


  Widget _milkCard(CowModel sapi, MilkModel milk) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: Container(
          padding: EdgeInsets.all(25),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sapi',
                        style:
                            kText10StyleBold.copyWith(color: Colors.black54),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              sapi.name ?? '-',
                              style: kText20StyleBold.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              (sapi.id ?? '-').toUpperCase(),
                              style: kText20StyleBold.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Laktasi Ke',
                        style:
                            kText10StyleBold.copyWith(color: Colors.black54),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '${milk.nBirth}',
                        style: kText20StyleBold.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Total Produksi Susu',
                        style:
                            kText10StyleBold.copyWith(color: Colors.black54),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '${(milk.morningMilk ?? 0) + (milk.afternoonMilk ?? 0)} L',
                        style: kText20StyleBold.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Produksi Susu Pagi',
                                  style: kText10StyleBold.copyWith(
                                      color: Colors.black54),
                                ),
                                Text(
                                  '${(milk.morningMilk ?? 0)} L',
                                  style: kText20StyleBold.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Produksi Susu Sore',
                                  style: kText10StyleBold.copyWith(
                                      color: Colors.black54),
                                ),
                                Text(
                                  '${(milk.afternoonMilk ?? 0)} L',
                                  style: kText20StyleBold.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              Flexible(
                flex: 1,
                child: Icon(
                  FontAwesome5.edit,
                  color: Clr.yellowPrimary,
                ),
              )
            ],
          )),
    );
  }

  Widget _noData() {
    return InkWell(
      onTap: () {
        // go to add birth item
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 45,
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Belum Ada Produksi Susu',
                style: kText12Style.copyWith(
                  color: Colors.black54,
                ),
              ),
              CircleAvatar(
                backgroundColor: Clr.yellowPrimary,
                radius: 10,
                child: Icon(
                  FontAwesome5.plus,
                  color: Colors.white,
                  size: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProduksiSusuController(),
        builder: (ProduksiSusuController controller) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Produksi Susu'),
              ),
              body: StreamBuilder<CowModel>(
                  stream: controller.outCowData,
                  builder: (context, cow) {
                    return StreamBuilder<DateTime?>(
                        stream: controller.outFocusedDay,
                        builder: (context, focused) {
                          return StreamBuilder<DateTime>(
                              stream: controller.outKFirstDay,
                              builder: (context, _firstDay) {
                                return StreamBuilder<DateTime>(
                                    stream: controller.outKLastDay,
                                    builder: (context, _lastDay) {
                                      return StreamBuilder<DateTime?>(
                                          stream: controller.outSelectedDay,
                                          builder: (context, selectedDay) {
                                            return Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  TableCalendar<MilkModel?>(
                                                    firstDay: _firstDay.data!,
                                                    lastDay: _lastDay.data!,
                                                    focusedDay: focused.data!,
                                                    selectedDayPredicate:
                                                        (day) => isSameDay(
                                                            selectedDay.data,
                                                            day),
                                                    calendarFormat:
                                                        CalendarFormat.month,
                                                    availableCalendarFormats: const {
                                                      CalendarFormat.month:
                                                          'Month',
                                                    },
                                                    eventLoader: (day) {
                                                      return controller
                                                          .getEventsForDay(day);
                                                    },
                                                    startingDayOfWeek:
                                                        StartingDayOfWeek
                                                            .monday,
                                                    calendarStyle:
                                                        CalendarStyle(
                                                      isTodayHighlighted: false,
                                                      canMarkersOverflow: true,
                                                      markerDecoration:
                                                          BoxDecoration(
                                                        color:
                                                            Clr.yellowPrimary,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      outsideDaysVisible: false,
                                                    ),
                                                    onDaySelected: controller
                                                        .onDaySelected,
                                                    onPageChanged:
                                                        (focusedDay) {
                                                      controller.inFocusedDay
                                                          .add(focusedDay);
                                                    },
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  StreamBuilder<
                                                      MilkModel?>(
                                                    stream: controller
                                                        .outSelectedEvents,
                                                    builder:
                                                        (context, value) {
                                                      if (value.data !=
                                                          null) {
                                                        return _milkCard(
                                                            cow.data!,
                                                            value.data!);
                                                      } else {
                                                        return _noData();
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    });
                              });
                        });
                  }));
        });
  }
}
