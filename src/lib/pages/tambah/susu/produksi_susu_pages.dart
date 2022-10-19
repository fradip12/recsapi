import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:src/common/arguments/arguments.dart';
import 'package:src/common/color/colors.dart';
import 'package:src/common/model/milk_model.dart';
import 'package:src/common/model/sapi_model.dart';
import 'package:src/common/widget/shimmer.dart';
import 'package:src/controller/tambah/susu/produksi_susu_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/style/text_style.dart';

class ProduksiSusu extends StatefulWidget {
  const ProduksiSusu({Key? key}) : super(key: key);

  @override
  State<ProduksiSusu> createState() => _ProduksiSusuState();
}

class _ProduksiSusuState extends State<ProduksiSusu> {
  Widget _milkCard(CowModel sapi, MilkModel milk, String selectedDay) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
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
                        style: kText10StyleBold.copyWith(color: Colors.black54),
                      ),
                      SizedBox(height: 5),
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
                      SizedBox(height: 5),
                      Text(
                        'Laktasi Ke',
                        style: kText10StyleBold.copyWith(color: Colors.black54),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${milk.nBirth}',
                        style: kText20StyleBold.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Total Produksi Susu',
                        style: kText10StyleBold.copyWith(color: Colors.black54),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${(milk.morningMilk ?? 0) + (milk.afternoonMilk ?? 0)} L',
                        style: kText20StyleBold.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
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
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/tambah-susu',
                        arguments: TambahProduksiSusuArguments(
                            sapi, selectedDay,
                            editData: milk));
                  },
                  child: Icon(
                    FontAwesome5.edit,
                    color: Clr.yellowPrimary,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _noData(CowModel data, String selectedDay) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // go to add birth item
            Get.toNamed('/tambah-susu',
                arguments: TambahProduksiSusuArguments(data, selectedDay));
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
        ),
        SizedBox()
      ],
    );
  }

  Widget _produksiSusuLoading() {
    return Column(
      children: [
        ShimmerWidget.rectRadius(
          height: Get.height / 2,
          width: double.infinity,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        ShimmerWidget.rectRadius(
          height: 125,
          width: double.infinity,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
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
                                child: StreamBuilder<
                                        LinkedHashMap<DateTime, MilkModel>>(
                                    stream: controller.outKEvents,
                                    builder: (context, events) {
                                      // if (events.connectionState ==
                                      //     ConnectionState.waiting) {
                                      //   return Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: _produksiSusuLoading(),
                                      //   );
                                      // }
                                      return Column(
                                        children: [
                                          TableCalendar<MilkModel?>(
                                            firstDay: _firstDay.data!,
                                            lastDay: _lastDay.data!,
                                            focusedDay:
                                                focused.data ?? DateTime.now(),
                                            selectedDayPredicate: (day) =>
                                                isSameDay(
                                                    selectedDay.data, day),
                                            calendarFormat:
                                                CalendarFormat.month,
                                            availableCalendarFormats: const {
                                              CalendarFormat.month: 'Month',
                                            },
                                            eventLoader:
                                                controller.getEventsForDay,
                                            startingDayOfWeek:
                                                StartingDayOfWeek.monday,
                                            calendarStyle: CalendarStyle(
                                              isTodayHighlighted: false,
                                              canMarkersOverflow: true,
                                              markerDecoration: BoxDecoration(
                                                color: Clr.yellowPrimary,
                                                shape: BoxShape.circle,
                                              ),
                                              outsideDaysVisible: false,
                                            ),
                                            onDaySelected:
                                                controller.onDaySelected,
                                            onPageChanged: (focusedDay) {
                                              controller.inFocusedDay
                                                  .add(focusedDay);
                                            },
                                          ),
                                          const SizedBox(height: 8.0),
                                          Expanded(
                                            child: StreamBuilder<MilkModel?>(
                                              stream:
                                                  controller.outSelectedEvents,
                                              builder: (context, value) {
                                                if (!value.hasData) {
                                                  return _noData(
                                                      cow.data!,
                                                      selectedDay.data!
                                                          .toIso8601String());
                                                }
                                                return _milkCard(
                                                  cow.data!,
                                                  value.data!,
                                                  selectedDay.data!
                                                      .toIso8601String(),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
