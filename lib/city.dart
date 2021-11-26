class City {
  String description;
  String place_id;

  City({
    required this.description,
    required this.place_id,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      description: json['description'],
      place_id: json['place_id']
    );
  }
}