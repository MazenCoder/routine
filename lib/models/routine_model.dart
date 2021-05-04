class RoutineModel {
  int id;
  String description;
  String duration;
  RoutineModel({
    this.id,
    this.duration,
    this.description,
  });

  factory RoutineModel.fromMap(Map<String, dynamic> json) => RoutineModel(
        id: json["id"],
        description: json["description"],
        duration: json["duration"],
      );
  Map<String, dynamic> toMap() =>
      {"id": id, "description": description, "duration": duration};
}
