import 'dart:io';
import 'package:dio/dio.dart';

import '../api_response.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final result = APIResponse(response: response);
    if (result.hasError) {
      final error = ErrorResponse.fromAPI(response);
      if (error.error == APIErrorType.unauthorized) {
        handler.reject(
            DioError(
                requestOptions: response.requestOptions,
                response: response..statusCode = HttpStatus.unauthorized,
                type: DioErrorType.response),
            true);
        return;
      }
    }
    super.onResponse(response, handler);
  }
}
