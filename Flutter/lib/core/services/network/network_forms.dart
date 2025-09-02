part of 'network_client.dart';

/// Dio request data
class RequestForm {
  final String path;
  final Object? data;
  final Map<String, dynamic>? queryParameters;
  final Options? options;
  final CancelToken? cancelToken;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;

  const RequestForm(
    this.path, {
    this.data,
    this.queryParameters,
    this.options,
    this.cancelToken,
    this.onSendProgress,
    this.onReceiveProgress,
  });

  @override
  bool operator ==(covariant RequestForm other) {
    bool equal = other.path == path;
    if (other.data == null && data == null) return equal;

    bool dataEquality = const DeepCollectionEquality.unordered().equals(other.data, data);
    return dataEquality && equal;
  }

  @override
  int get hashCode => Object.hash(path, data);
}

/// MultiPart request form
class MultiPartForm {
  final String filePath;
  final String? filename;
  final MediaType? contentType;
  final Map<String, List<String>>? headers;

  const MultiPartForm(
    this.filePath, {
    this.filename,
    this.contentType,
    this.headers,
  });

  @override
  bool operator ==(covariant MultiPartForm other) => other.filePath == filePath;

  @override
  int get hashCode => filePath.hashCode;
}
