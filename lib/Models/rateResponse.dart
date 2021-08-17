
class RateResponse {
  RateResponse({
    this.name,
    this.description,
    this.rate,
  });

  String name;
  String description;
  double rate;

  factory RateResponse.fromJson(Map<String, dynamic> json) => RateResponse(
    name: json["name"],
    description: json["description"],
    rate: double.parse(json["rate"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "rate": rate,
  };
}
