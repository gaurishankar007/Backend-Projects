import '../../injection/injector.dart';

Map<String, String> reqHeaders({bool isFormData = false}) {
  String accessToken = appData.userData.accessToken;
  Map<String, String> header = {
    "Authorization": "Bearer $accessToken",
  };

  header["Content-Type"] = isFormData ? "multipart/form-data" : "application/json";

  return header;
}
