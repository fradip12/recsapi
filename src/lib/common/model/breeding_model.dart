// To parse this JSON data, do
//
//     final BreedingModel = BreedingModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


class BreedingModel {
    BreedingModel({
        this.id,
        this.cowId,
        this.strowNumber,
        this.maleId,
        this.sc,
        this.breedDate,
        this.maleName,
        this.pregnantState,
    });

    String? id;
    String? cowId;
    String? strowNumber;
    String? maleId;
    String? maleName;
    String? breedDate;
    int? sc;
    bool? pregnantState;

    factory BreedingModel.fromJson(Map<String, dynamic> json) => BreedingModel(
        id: json["id"],
        cowId: json["cow_id"],
        strowNumber: json["strow_number"],
        maleId: json["male_id"],
        maleName: json["male_name"],
        sc: json["sc"],
        breedDate: json["breed_date"],
        pregnantState: json["pregnant_state"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cow_id": cowId,
        "strow_number": strowNumber,
        "male_id": maleId,
        "male_name": maleName,
        "sc": sc,
        "breed_date":breedDate,
        "pregnant_state":pregnantState,
    };
}
