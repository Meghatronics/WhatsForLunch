/// [BaseDatasource] 
/// 
/// Mixin interface to send Http requests and process the response
/// to [ApiResponse] of type [<Map<String, dynamic>>]
/// 
/// Utilize the transform and transformToStatusOnly functions extended on 
/// [ApiResponse<Map<String, dynamic>>] to convert ApiResponses from your 
/// datasources, to values/models you wish to use. 
/// 
/// Returns error as [NetworkFailure] if request cannot connect. 
/// 
/// Returns error as [ServerFailure] if status code **500** is returned, 
/// or if body returned cannot be decoded (body is not json). 
/// 
/// Return error as [InputFailure] if server returns error based on 
/// conditions set in private function `_checkForError`
/// 
/// Original written by Flutterian MajorE 
/// Github: @Meghatronics Twitter: @MajorE_1

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';

import '../../utilities/constants/constants.dart';
import 'api_response.dart';
import 'exceptions.dart';
import 'failures.dart';

mixin BaseDatasource {
  final String baseUrl = apiBaseUrl;

  static String _token;

  static set token(String token) {
    _token = token;
  }

  String get userToken => _token;
  Map<String, String> get jsonHeadersWithoutToken => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

  Map<String, String> get jsonHeaders => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };

  Future<ApiResponse<Map<String, dynamic>>> _processRequest(
    Future<http.Response> request,
  ) async {
    try {
      final response = await request.catchError(
        (_) => throw NetworkException(),
      );
      print('RESPONSE BODY ---- ${response.body}');
      final data = jsonDecode(response.body);
      final error = _checkForError(response.statusCode, data);
      return ApiResponse(
        data: data,
        error: error,
      );
    } on FormatException {
      return ApiResponse(error: ServerFailure());
    } catch (e) {
      return ApiResponse(error: convertException(e));
    }
  }

  ///Send a http *GET* request to "`$baseUrl$`[endpoint]"
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendGet(
      {@required String endpoint, bool useToken = true}) {
    final url = Uri.parse('$baseUrl$endpoint');
    final request = http.get(url);
    return _processRequest(request);
  }

  ///Send a http *POST* request to "`$baseUrl$`[endpoint]".
  ///[payload] is encoded and sent as request body.
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendPost(
      {@required String endpoint,
      @required Map<String, dynamic> payload,
      bool useToken = true}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final body = payload != null ? jsonEncode(payload) : null;
    final request = http.post(
      url,
      body: body,
      headers: useToken ? jsonHeaders : jsonHeadersWithoutToken,
    );
    return _processRequest(request);
  }

  ///Send a http *PATCH* request to "`$baseUrl$`[endpoint]".
  ///[payload] is encoded and sent as request body.
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendPatch(
      {@required String endpoint,
      @required Map<String, dynamic> payload,
      bool useToken = true}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final body = payload != null ? jsonEncode(payload) : null;
    final request = http.patch(
      url,
      body: body,
      headers: useToken ? jsonHeaders : jsonHeadersWithoutToken,
    );
    return _processRequest(request);
  }

  ///Send a http *PUT* request to "`$baseUrl$`[endpoint]".
  ///[payload] is encoded and sent as request body.
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse> sendPut(
      {@required String endpoint,
      @required Map<String, dynamic> payload,
      bool useToken = true}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final body = payload != null ? jsonEncode(payload) : null;
    final request = http.put(
      url,
      body: body,
      headers: useToken ? jsonHeaders : jsonHeadersWithoutToken,
    );
    return _processRequest(request);
  }

  ///Send a http *MULTIPART* request to "`$baseUrl$`[endpoint]"
  ///with [imageKey] as [image].
  ///
  ///Map key and value in [fields] are added to the request if !null or empty
  ///Authorisation token is added to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendImageFile({
    @required File image,
    @required String imageKey,
    @required String endpoint,
    Map<String, dynamic> fields,
  }) async {
    // Make request variable with url
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl$endpoint'),
    );
// Add authorisation header to request variable
    request.headers.putIfAbsent(
      'Authorization',
      () => jsonHeaders['Authorization'],
    );
// Add the image file to request variable as imageKey
    request.files.add(await http.MultipartFile.fromPath(
      '$imageKey',
      image.path,
      contentType: MediaType('image', 'jpeg'),
    ));
// If other fields exist, add them to the request
    if (fields != null && fields.isNotEmpty) {
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
    }
// Send the request and receive a stream as response
//     final responseStream = await (request.send());
// Convert the stream returned to regular response
    final multipartRequest = http.Response.fromStream(await request.send());
    return _processRequest(multipartRequest);
  }

  Failure _checkForError(int statusCode, data) {
    String returnedMessage;

    if (data != null) {
      //Check if request was successful
      final success = data['status'] == 'success';
      //If successful, return no failure
      if (success ?? false) return null;

      //Check list of errors
      final errors = data['errors'] as Map;

      //If no error field - use messsage for failure
      if (errors == null || errors.isEmpty) {
        returnedMessage = data['message'];
      }
      //If there are error fields - use errors for failure
      else {
        returnedMessage = '';
        errors.forEach((key, value) {
          returnedMessage = '$returnedMessage\n${value[0]}';
        });
      }
    }
    switch (statusCode) {
      case 200:
        return null;
        break;
      case 403:
        return BadAuthFailure(errorMessage: returnedMessage);
        break;
      case 500:
        return ServerFailure(error: returnedMessage);
        break;
      default:
        return InputFailure(errorMessage: returnedMessage);
    }
  }
}
