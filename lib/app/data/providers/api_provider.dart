import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/api/client.dart';
import '../../core/api/exception.dart';
import '../models/token.dart';

abstract class ApiProvider {
  static const int timeOutDuration = 200;

  static Future<dynamic> get(
      {bool auth = true, required String apiURL, bool isPhone = false}) async {
    try {
      String token = !isPhone ? Token.getAuthToken() : Token.getPhoneToken();
      var response = await http
          .get(Uri.parse(ApiClient.baseUrl + apiURL),
              headers: ApiClient.headers(auth: auth, token: token))
          .timeout(const Duration(seconds: timeOutDuration));
      return ApiClient.processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }

  static Future<dynamic> post(
      {required bool auth,
      required Map<String, dynamic> data,
      required String apiURL,
      bool isPhone = false}) async {
    try {
      String token = !isPhone ? Token.getAuthToken() : Token.getPhoneToken();
      var response = await http
          .post(Uri.parse(ApiClient.baseUrl + apiURL),
              body: jsonEncode(data),
              headers: ApiClient.headers(auth: auth, token: token))
          .timeout(const Duration(seconds: timeOutDuration));

      return ApiClient.processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }

  static Future<dynamic> put({
  required bool auth,
  required Map<String, dynamic> data,
  String? baseURL,
  required String apiURL,
}) async {
  try {
    var response = await http
        .put(Uri.parse((baseURL ?? ApiClient.baseUrl) + apiURL),
            body: jsonEncode(data),
            headers: ApiClient.headers(auth: auth))
        .timeout(const Duration(seconds: timeOutDuration));

    return ApiClient.processResponse(response);
  } on SocketException {
    throw FetchDataException('No Internet connection', '');
  } on TimeoutException {
    throw ApiNotRespondingException('API not responded in time', '');
  }
}

  // Nouvelle méthode pour les requêtes multipart (upload de fichiers)
  static Future<dynamic> multipartPost({
    required bool auth,
    required String apiURL,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiClient.baseUrl + apiURL),
      );

      // Ajout des headers d'authentification
      request.headers.addAll(ApiClient.headers(auth: auth));

      // Ajout des champs texte
      request.fields.addAll(fields);

      // Ajout des fichiers
      request.files.addAll(files);

      // Envoi de la requête avec timeout
      final response = await request
          .send()
          .timeout(const Duration(seconds: timeOutDuration));

      // Conversion de la réponse
      final responseString = await response.stream.bytesToString();

      return ApiClient.processResponse(http.Response(
        responseString,
        response.statusCode,
        headers: response.headers,
      ));
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }

  static Future<dynamic> multipartUpdate({
    required bool auth,
    required String apiURL,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiClient.baseUrl + apiURL),
      );

      // Ajout des headers d'authentification
      request.headers.addAll(ApiClient.headers(auth: auth));

      // Ajout des champs texte
      request.fields.addAll(fields);

      // Ajout des fichiers
      request.files.addAll(files);

      // Envoi de la requête avec timeout
      final response = await request
          .send()
          .timeout(const Duration(seconds: timeOutDuration));

      // Conversion de la réponse
      final responseString = await response.stream.bytesToString();

      return ApiClient.processResponse(http.Response(
        responseString,
        response.statusCode,
        headers: response.headers,
      ));
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }

  static Future<dynamic> delete(
      {bool auth = false, required String apiURL}) async {
    try {
      String token = Token.getAuthToken();
      var response = await http
          .delete(Uri.parse(ApiClient.baseUrl + apiURL),
              headers: ApiClient.headers(auth: auth, token: token))
          .timeout(const Duration(seconds: timeOutDuration));
      return ApiClient.processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', '');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', '');
    }
  }
}
