String get baseUrl => "http://192.168.3.133:8080";
String get apiUrl => "$baseUrl/api";
String get authUrl => "$apiUrl/auth";
String get chatUrl => "$apiUrl/chat";
String get messageUrl => "$apiUrl/message";

// Auth
String get signInUrl => "$authUrl/login";
String get signUpUrl => "$authUrl/register";
String get updateProfileUrl => "$authUrl/updateProfilePic";
