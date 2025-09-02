import 'package:get_it/get_it.dart';

import '../services/user_service.dart';

Map<String, String> authHeaders({bool isForm = false}) {
  String accessToken = GetIt.I<UserService>().userData.accessToken;

  Map<String, String> header = {
    "Authorization": "Bearer $accessToken",
    "Content-Type": isForm ? "multipart/form-data" : "application/json"
  };

  return header;
}
