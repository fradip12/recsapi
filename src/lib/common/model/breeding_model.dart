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
        this.male,
        this.sc,
        this.breedDate
    });

    String? id;
    String? cowId;
    String? strowNumber;
    String? male;
    String? breedDate;
    int? sc;

    factory BreedingModel.fromJson(Map<String, dynamic> json) => BreedingModel(
        id: json["id"],
        cowId: json["cow_id"],
        strowNumber: json["strow_number"],
        male: json["male"],
        sc: json["sc"],
        breedDate: json["breed_date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cow_id": cowId,
        "strow_number": strowNumber,
        "male": male,
        "sc": sc,
        "breed_date":breedDate
    };
}
