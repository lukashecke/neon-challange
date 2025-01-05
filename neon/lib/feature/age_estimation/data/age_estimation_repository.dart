import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neon/constants.dart';
import 'package:neon/feature/age_estimation/model/age_estimation.dart';

/// The repository for the age estimation feature.
class AgeEstimationRepository {
  /// Fetches the age estimation of the given name.
  Future<AgeEstimation> fetchNameEstimation(String name) async {
    final response = await http
        .get(Uri.parse('${Constants.apiPath}${Constants.apiNameParam}$name'));

    if (response.statusCode == 200) {
      return AgeEstimation.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load age estimation');
    }
  }
}
