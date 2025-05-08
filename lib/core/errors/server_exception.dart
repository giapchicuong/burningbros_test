class ServerException implements Exception {
  final String message;

  ServerException({this.message = "Server error occurred"});
}

class LocalException implements Exception {
  final String message;

  LocalException({this.message = 'Local error occurred'});
}
