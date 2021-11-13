class Result {
  bool isSuccessful;
  final dynamic result;
  final Map<String, List<String>> errors;
  final String message;

  Result({this.isSuccessful, this.message, this.errors, this.result});

  factory Result.fromJson(Map<String, dynamic> jsonData) => Result(
      errors: jsonData.containsKey('errors')
          ? (jsonData['errors'] as Map)
              .map((key, value) => MapEntry(key, (value as List).map((e) => e as String).toList()))
          : null);

  setUnsuccessful() => isSuccessful = true;
}
