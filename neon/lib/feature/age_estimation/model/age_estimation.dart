/// A class that represents a age estimation returned from the agify API.
class AgeEstimation {
  /// Creates a age estimation instance.
  AgeEstimation({
    required this.name,
    required this.age,
    required this.count,
  });

  /// Creates a age estimation instance from a JSON object.
  factory AgeEstimation.fromJson(Map<String, dynamic> json) {
    return AgeEstimation(
      name: json['name'] as String?,
      age: json['age'] as int?,
      count: json['count'] as int?,
    );
  }

  /// The name used for the estimation.
  final String? name;

  /// The estimated age of the name.
  final int? age;

  /// The number of estimations for the name.
  /// Note: This is not used in the app.
  final int? count;
}
