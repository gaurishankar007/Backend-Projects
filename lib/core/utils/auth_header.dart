import '../../injection/injector.dart';

Map<String, String> authHeader({bool formData = false}) {
  String accessToken = appData.userData.accessToken;
  Map<String, String> header = {
    "Authorization": "Bearer $accessToken",
  };

  if (formData) header["Content-Type"] = "multipart/form-data";

  return header;
}
