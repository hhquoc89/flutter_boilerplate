import 'dart:io';

import 'package:dio/dio.dart';

import '../../configs/constants.dart';
import '../api_client.dart';
import 'auth_interceptor.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  APIClient apiClient;
  Function unauthorizedCallback;
  Function(DioErrorType errorType)? onErrorCallback;
  Function(DioErrorType errorType)? onNetworkErrorCallback;
  bool hasUnAuthorizeBefore = false;

  ErrorInterceptor(this.apiClient,
      {required this.unauthorizedCallback,
      this.onErrorCallback,
      this.onNetworkErrorCallback});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (hasUnAuthorizeBefore) hasUnAuthorizeBefore = false;
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioErrorType.cancel:
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        if (onErrorCallback != null) {
          onErrorCallback!(err.type);
        }
        break;
      case DioErrorType.other:
        // final isOffline = _checkConnection(error);
        // Response response;
        // if (isOffline) {
        //   response = await _handleOfflineRequest(error);
        // } else {
        //   response = error.response;
        // }
        if (onNetworkErrorCallback != null && err.error is SocketException) {
          onNetworkErrorCallback!(err.type);
        }
        break;
      case DioErrorType.response:

        ///Unauthorized, may be the access token has been expired
        if (err.response!.statusCode == HttpStatus.unauthorized &&
            err.requestOptions
                    .extra[AppConstants.ignoreNavigateWhenUnAuthorize] !=
                true &&
            !hasUnAuthorizeBefore) {
          hasUnAuthorizeBefore = true;
          apiClient.instance.lock();

          (apiClient.instance.interceptors.first as AuthInterceptor)
                  .token
                  .accessToken =
              "eyJraWQiOiJtUTBnSTNUXC9QdW1kV241V0tVblVnNStLYTUxK0dQNktrckVCSTg0TlgzWT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI0ZmFiODdkNS1kOTJiLTRkNmItODRkYy0wMzMyZmFiNmFjOWIiLCJhdWQiOiI2cm4xMjBjbXRpNWNpbzdtc2twcmgxc2pnZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJldmVudF9pZCI6IjVkYTAzYWQ2LTdkZWEtNDdiOS1iN2I0LWZlYmYwYWRkMDA5NSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNjE2NzMwMjkzLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfYkxURmJORWpoIiwiY29nbml0bzp1c2VybmFtZSI6IjRmYWI4N2Q1LWQ5MmItNGQ2Yi04NGRjLTAzMzJmYWI2YWM5YiIsImV4cCI6MTYxNjczMzk1NiwiaWF0IjoxNjE2NzMwMzU3LCJlbWFpbCI6Im5obmdoaWEyNDA2QGdtYWlsLmNvbSJ9.THSjPIJnEm1sFkKt4gywEo1yY9ByYv_BklXPxPk3fVyw9Nx_NBUzVpT-r-6vXILjZ_TV5NEZee9AX_PxwMMeUxK4FbeFvNSgtLydIlkM-vilSkxnZRdRsKG96q6z7qz89pd7vhBL1oanBtIWFx2zVx0lw65vkmf8R0XjOBvIcfbXqJRGSEnZtAZXo73PX7wffuGq-cZMbvMK_ERibTPwjyZ0aaQvXl58cT9U2POutEKpKaOIpl4E7dYeIjFkEvEyq1f05x318xvQ9XGMkhowf7JbTbIbAkmNsYIY20IA4As8OliU0Z5_G8_RDS0oCY-ugfDQa0Etq2m6zYAKeyKouw";
          apiClient.instance.unlock();
          try {
            final Response prevResponse =
                await apiClient.instance.fetch(err.requestOptions);
            handler.resolve(prevResponse);
            return;
          } on DioError catch (e) {
            unauthorizedCallback();
            err=e;
          }
        }

        break;
    }
    super.onError(err, handler);
  }

// Future<Response> _handleOfflineRequest(DioError error) async {
//   var offlineCompleter = Completer<Response>();
//   Connectivity().onConnectivityChanged.listen((connectionState) async {
//     if (connectionState != ConnectivityResult.none) {
//       apiClient.dio.unlock();
//       final response = await apiClient.dio.fetch(error.requestOptions);
//       if (response != null) {
//         offlineCompleter.complete(response);
//       } else {
//         offlineCompleter.completeError(DioErrorType.other);
//       }
//       offlineCompleter = Completer();
//     }
//   });
//   return offlineCompleter.future;
// }

// _checkConnection(DioError error) {
//   return error.type == DioErrorType.other &&
//       error.error != null &&
//       error.error is SocketException;
// }
}
