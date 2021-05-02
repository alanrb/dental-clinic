class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
class NetworkException implements Exception {}
class UnAuthorisedException implements Exception {}
class UnKnownException implements Exception {}