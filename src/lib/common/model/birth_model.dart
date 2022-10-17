// To parse this JSON data, do
//
//     final BirthModel = BirthModelFromJson(jsonString);


class BirthModel {
    BirthModel({
        this.id,
        this.breedingId,
        this.numberOfBirth,
        this.condition,
        this.process,
        this.birthdate,
        this.birthType,
        this.birthWeight,
    });

    String? id;
    String? breedingId;
    int? numberOfBirth;
    String? condition;
    String? process;
    String? birthdate;
    String? birthType;
    String? birthWeight;

    factory BirthModel.fromJson(Map<String, dynamic> json) => BirthModel(
        id: json["id"],
        breedingId: json["breeding_id"],
        numberOfBirth: json["number_of_birth"],
        condition: json["condition"],
        process: json["process"],
        birthdate: json["birthdate"],
        birthType: json["birth_type"],
        birthWeight: json["birth_weight"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "breeding_id": breedingId,
        "number_of_birth": numberOfBirth,
        "condition": condition,
        "process": process,
        "birthdate": birthdate,
        "birth_type": birthType,
        "birth_weight": birthWeight,
    };
}
