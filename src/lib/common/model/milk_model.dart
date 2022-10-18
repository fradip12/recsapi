// To parse this JSON data, do
//
//     final MilkModel = MilkModelFromJson(jsonString);

class MilkModel {
  MilkModel({
    this.id,
    this.cowId,
    this.morningMilk,
    this.afternoonMilk,
    this.nBirth,
    this.nDay,
    this.date,
  });

  String? id;
  String? cowId;
  int? morningMilk;
  int? afternoonMilk;
  int? nBirth;
  int? nDay;
  String? date;

  factory MilkModel.fromJson(Map<String, dynamic> json) => MilkModel(
        id: json["id"],
        cowId: json["cow_id"],
        morningMilk: json["morning_milk"],
        afternoonMilk: json["afternoon_milk"],
        nBirth: json["n_birth"],
        nDay: json["n_day"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cow_id": cowId,
        "morning_milk": morningMilk,
        "afternoon_milk": afternoonMilk,
        "n_birth": nBirth,
        "n_day": nDay,
        "date": date,
      };

  MilkModel.empty()
      : this(
          id: '',
          cowId: '',
          morningMilk: 0,
          afternoonMilk: 0,
          nBirth: 0,
          nDay: 0,
          date: '',
        );
}
