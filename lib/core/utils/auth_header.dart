import '../../injection/injector.dart';

Map<String, String> authHeader({bool formData = false}) {
  String accessToken = appData.userData.accessToken;
  Map<String, String> header = {
    "Authorization": "Bearer $accessToken",
  };

  header["Content-Type"] = formData ? "multipart/form-data" : "application/json";

  return header;
}
