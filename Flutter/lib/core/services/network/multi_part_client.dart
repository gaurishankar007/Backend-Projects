part of 'network_client.dart';

abstract class MultiPartClient {
  Future<MultipartFile> multipartFromFile(MultiPartForm form);
}

class MultiPartClientImplementation implements MultiPartClient {
  @override
  Future<MultipartFile> multipartFromFile(MultiPartForm form) async {
    return await MultipartFile.fromFile(
      form.filePath,
      filename: form.filename,
      contentType: form.contentType,
      headers: form.headers,
    );
  }
}
