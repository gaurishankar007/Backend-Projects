import '../../injector/injector.dart';

Map<String, String> authHeaders({bool isForm = false}) {
  String accessToken = userService.userData.accessToken;

  Map<String, String> header = {
    "Authorization": "Bearer $accessToken",
    "Content-Type": isForm ? "multipart/form-data" : "application/json"
  };

  return header;
}
