String get baseUrl => "http://192.168.3.145:8080";

/// <===== Assets =====>
String get publicUrl => "$baseUrl/public";
String get profileUrl => "$publicUrl/profiles";
String get imageUrl => "$publicUrl/images";
String get audioUrl => "$publicUrl/audios";
String get videoUrl => "$publicUrl/videos";

/// <===== End Points =====>
String get apiUrl => "$baseUrl/api";
String get authUrl => "$apiUrl/auth";
String get chatUrl => "$apiUrl/chat";
String get messageUrl => "$apiUrl/message";

/// Auth
String get signInUrl => "$authUrl/login";
String get signUpUrl => "$authUrl/register";
String get updateProfileUrl => "$authUrl/updateProfile";
