import 'dart:io';

import 'package:dio/dio.dart';

import '../configs/constants.dart';
import 'api_data_transformer.dart';
import 'decodable.dart';

typedef GenericObject<T> = T Function(dynamic _);

///T Original response type
class BaseAPIResponseWrapper<R, E> {
  R? originalResponse;
  E? decodedData;

  ///For default, any response should have it
  int? status;
  String? statusMessage;
  bool hasError = false;
  BaseAPIResponseDataTransformer? dataTransformer;

  BaseAPIResponseWrapper({this.originalResponse, this.dataTransformer});

  Map<String, dynamic> extractJson() {
    dataTransformer ??= DioResponseDataTransformer();
    return dataTransformer!.extractData(originalResponse);
  }

  void decode(Map<String, dynamic> formatResponse, {dynamic createObject}) {
    status = formatResponse[AppConstants.rootAPIStatusFormat];
    hasError = formatResponse[AppConstants.rootAPIStatusFormat] != 200;
    statusMessage = formatResponse[AppConstants.rootAPIStatusMessageFormat];
  }
}

class APIResponse<T> extends BaseAPIResponseWrapper<Response, T> {
  APIResponse({T? createObject, Response? response})
      : super(originalResponse: response) {
    decode(extractJson(), createObject: createObject);
  }

  @override
  void decode(Map<String, dynamic> formatResponse, {createObject}) {
    super.decode(formatResponse, createObject: createObject);
    if (createObject is Decoder && !hasError) {
      decodedData = createObject.decode(formatResponse["data"]);
    } else if (T == dynamic) {
      decodedData = formatResponse["data"];
    } else {
      final data = formatResponse["data"];
      if (data is T) decodedData = data;
    }
  }
}

class APIListResponse<T> extends BaseAPIResponseWrapper<Response, List<T>> {
  APIListResponse({T? createObject, Response? response})
      : super(
          originalResponse: response,
        ) {
    decode(extractJson(), createObject: createObject);
  }

  @override
  void decode(Map<String, dynamic> formatResponse, {dynamic createObject}) {
    super.decode(formatResponse, createObject: createObject);
    if (createObject is Decoder && !hasError) {
      final data = formatResponse["data"];
      if (data is List && data.isNotEmpty) {
        decodedData ??= <T>[];
        for (final e in data) {
          (decodedData as List).add(createObject.decode(e));
        }
      }
      decodedData ??= <T>[];
    }
  }
}

class ErrorResponse extends BaseAPIResponseWrapper<Response, dynamic>
    implements Exception {
  late APIErrorType error;

  ErrorResponse.fromAPI(Response? originalResponse)
      : super(
          originalResponse: originalResponse,
        ) {
    decode(extractJson());
    hasError = true;
  }

  @override
  void decode(Map<String, dynamic> formatResponse, {createObject}) {
    super.decode(formatResponse);
    error = getErrorType(formatResponse[AppConstants.rootAPIStatusFormat]);
  }

  ErrorResponse.fromSystem(this.error, String message) {
    hasError = true;
    status = 400;
    statusMessage = message;
  }

  APIErrorType getErrorType(dynamic error) {
    if (error == HttpStatus.unauthorized) {
      return APIErrorType.unauthorized;
    }
    return APIErrorType.unknown;
  }
}

enum APIErrorType { unauthorized, unknown }
