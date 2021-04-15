import 'package:meta/meta.dart';

class ServerException implements Exception {
  final String errorMessage;
  ServerException({this.errorMessage});
}

class InputException implements Exception {
  final String errorMessage;
  InputException({@required this.errorMessage});
}

class UnauthorisedException implements Exception {
  final String errorMessage;
  UnauthorisedException({this.errorMessage});
}

class NetworkException implements Exception {}

class UnknownException implements Exception {}
