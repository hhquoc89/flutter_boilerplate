import 'dart:convert';

import 'package:dio/dio.dart';

import '../configs/constants.dart';
import '../configs/flavor_config.dart';
import 'api_response.dart';
import 'api_route.dart';

abstract class BaseAPIClient {
  Future<T> request<T>(
      {required APIRouteConfigurable route,
      required GenericObject<T> create,
      Map<String, dynamic>? params,
      String? extraPath,
      bool noEncode = false,
      bool ignoreNavigateWhenUnAuthorize = false,
      Map<String, dynamic> header,
      Map<String, dynamic>? body});
}

class APIClient implements BaseAPIClient {
  late BaseOptions options;
  late Dio instance;

  APIClient() {
    options = BaseOptions(
      baseUrl: "${FlavorConfig.instance?.values.baseUrl}/api",
      headers: {"Content-Type": "application/json"},
      responseType: ResponseType.json,
      validateStatus: (code) {
        if (code! <= 201) return true;
        return false;
      },
    );
    instance = Dio(options);
  }

  @override
  Future<T> request<T>(
      {required APIRouteConfigurable route,
      required GenericObject<T> create,
      Map<String, dynamic>? params,
      bool noEncode = false,
      bool ignoreNavigateWhenUnAuthorize = false,
      Map<String, dynamic>? header,
      String? extraPath,
      Map<String, dynamic>? body}) async {
    final RequestOptions? requestOptions = route.getConfig(options);

    if (requestOptions != null) {
      if (params != null) {
        requestOptions.queryParameters = params.map((key, value) {
          if (value != String && value is! String) {
            String encodedValue = jsonEncode(value);
            if (noEncode) {
              final remove1 = RegExp(r"\\+");
              final remove2 = RegExp(r'\"(?=[\(])|(?<=[\)!])"');
              encodedValue = encodedValue.replaceAll(remove1, "");
              encodedValue = encodedValue.replaceAll(remove2, "");
              return MapEntry(key, encodedValue);
            }
            return MapEntry(key, encodedValue);
          }
          return MapEntry(key, value);
        });
      }
      if (extraPath != null) requestOptions.path += extraPath;
      requestOptions.extra[AppConstants.ignoreNavigateWhenUnAuthorize] =
          ignoreNavigateWhenUnAuthorize;
      if (header != null) requestOptions.headers.addAll(header);
      if (body != null) {
        requestOptions.data = body;
      }

      try {
        Response response = await instance.fetch(requestOptions);
        T apiWrapper = create(response);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (apiWrapper is BaseAPIResponseWrapper) {
            if (apiWrapper.hasError) throw ErrorResponse.fromAPI(response);
            return apiWrapper;
          }

          ///If you want to use another object type such as primitive type, but you need to ensure that the response type will match your expected type
          if (response.data is T) {
            return response.data;
          } else {
            throw ErrorResponse.fromSystem(APIErrorType.unknown,
                "Can not match the $T type with ${response.data.runtimeType}");
          }
        }
        throw ErrorResponse.fromAPI(response);
      } on DioError catch (e) {
        throw ErrorResponse.fromAPI(e.response);
      }
    } else {
      throw ErrorResponse.fromSystem(
          APIErrorType.unknown, "Missing request options");
    }
  }
}
