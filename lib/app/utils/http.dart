import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_alice/core/alice_http_extensions.dart';
import 'package:flutter_kag/app/config/env.dart';
import 'package:flutter_kag/app/utils/toast.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final _http = http.Client();
  static const timeout = 20;
  Future<dynamic> get(String endpoint) async {
    var uri = Uri.parse(Env.api + endpoint);

    try {
      var response = await _http
          .get(uri)
          .timeout(const Duration(seconds: timeout))
          .interceptWithAlice(Env.alice);
      return responseHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('API not responded');
    }
  }

  handleError(error) {
    ToastUtil.showSnackBarError('Error', error.toString());
  }

  responseHandler(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
        throw InternalServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode} -> ${response.body}');
    }
  }
}

class CustomException implements Exception {
  CustomException([this._message, this._prefix]);

  final dynamic _message;
  final dynamic _prefix;

  @override
  String toString() {
    return "$_prefix $_message";
  }

  String getMessage() {
    return _message;
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "Failed Get Data");
}

class BadRequestException extends CustomException {
  BadRequestException([String? message]) : super(message, "Invalid Request");
}

class InternalServerErrorException extends CustomException {
  InternalServerErrorException([String? message])
      : super(message, "Invalid Request");
}

class NotFoundException extends CustomException {
  NotFoundException([String? message]) : super(message, "Not Found");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([String? message]) : super(message, "Unauthorized");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input");
}
