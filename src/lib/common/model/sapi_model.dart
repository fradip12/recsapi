// To parse this JSON data, do
//
//     final cowModel = cowModelFromJson(jsonString);

import 'dart:convert';

class CowModel {
  CowModel({
    this.id,
    this.name,
    this.breed,
    this.gender,
    this.color,
    this.birthdate,
    this.parentM,
    this.parentF,
    this.strowNumber,
    this.notes,
    this.weightBirth,
    this.weight4Mo,
    this.weight1Yo,
    this.chestCircumference1Yo,
    this.bodyLength1Yo,
    this.gumbaHeight1Yo,
    this.uniqueId,
  });

   String? id;
   String? name;
   String? breed;
   int? gender;
   String? color;
   String? birthdate;
   String? parentM;
   String? parentF;
   String? strowNumber;
   String? notes;
   double? weightBirth;
   double? weight4Mo;
   double? weight1Yo;
   double? chestCircumference1Yo;
   double? bodyLength1Yo;
   double? gumbaHeight1Yo;
   String? uniqueId;

  CowModel copyWith({
    String? id,
    String? name,
    String? breed,
    int? gender,
    String? color,
    String? birthdate,
    String? parentM,
    String? parentF,
    String? strowNumber,
    String? notes,
    double? weightBirth,
    double? weight4Mo,
    double? weight1Yo,
    double? chestCircumference1Yo,
    double? bodyLength1Yo,
    double? gumbaHeight1Yo,
    String? uniqueId,
  }) =>
      CowModel(
        id: id ?? this.id,
        name: name ?? this.name,
        breed: breed ?? this.breed,
        gender: gender ?? this.gender,
        color: color ?? this.color,
        birthdate: birthdate ?? this.birthdate,
        parentM: parentM ?? this.parentM,
        parentF: parentF ?? this.parentF,
        strowNumber: strowNumber ?? this.strowNumber,
        notes: notes ?? this.notes,
        weightBirth: weightBirth ?? this.weightBirth,
        weight4Mo: weight4Mo ?? this.weight4Mo,
        weight1Yo: weight1Yo ?? this.weight1Yo,
        chestCircumference1Yo:
            chestCircumference1Yo ?? this.chestCircumference1Yo,
        bodyLength1Yo: bodyLength1Yo ?? this.bodyLength1Yo,
        gumbaHeight1Yo: gumbaHeight1Yo ?? this.gumbaHeight1Yo,
        uniqueId: uniqueId ?? this.uniqueId,
      );

  factory CowModel.fromRawJson(String str) =>
      CowModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CowModel.fromJson(Map<String, dynamic> json) => CowModel(
        id: json["id"],
        name: json["name"],
        breed: json["breed"],
        gender: json["gender"],
        color: json["color"],
        birthdate: json["birthdate"],
        parentM: json["parent_m"],
        parentF: json["parent_f"],
        strowNumber: json["strow_number"],
        notes: json["notes"],
        weightBirth: json["weight_birth"],
        weight4Mo: json["weight_4mo"],
        weight1Yo: json["weight_1yo"],
        chestCircumference1Yo: json["chest_circumference_1yo"],
        bodyLength1Yo: json["body_length_1yo"],
        gumbaHeight1Yo: json["gumba_height_1yo"],
        uniqueId: json["unique_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "breed": breed,
        "gender": gender,
        "color": color,
        "birthdate": birthdate,
        "parent_m": parentM,
        "parent_f": parentF,
        "strow_number": strowNumber,
        "notes": notes,
        "weight_birth": weightBirth,
        "weight_4mo": weight4Mo,
        "weight_1yo": weight1Yo,
        "chest_circumference_1yo": chestCircumference1Yo,
        "body_length_1yo": bodyLength1Yo,
        "gumba_height_1yo": gumbaHeight1Yo,
        "unique_id": uniqueId,
      };

  CowModel.empty()
      : birthdate = null,
        id = null,
        name = null,
        breed = null,
        gender = null,
        color = null,
        parentM = null,
        parentF = null,
        strowNumber = null,
        notes = null,
        weightBirth = null,
        weight4Mo = null,
        weight1Yo = null,
        chestCircumference1Yo = null,
        bodyLength1Yo = null,
        gumbaHeight1Yo = null,
        uniqueId = null;
}
