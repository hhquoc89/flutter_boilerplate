import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../configs/constants.dart';
import '../api_client.dart';
import '../decodable.dart';

extension Curl on RequestOptions {
  String toCurlCmd() {
    String cmd = "curl";

    String header = headers
        .map((key, value) {
          if (key == "content-type" &&
              value.toString().contains("multipart/form-data")) {
            value = "multipart/form-data;";
          }
          return MapEntry(key, "-H '$key: $value'");
        })
        .values
        .join(" ");
    String url = "$baseUrl$path";
    if (queryParameters.isNotEmpty) {
      String query = queryParameters
          .map((key, value) {
            return MapEntry(key, "$key=$value");
          })
          .values
          .join("&");

      url += (url.contains("?")) ? query : "?$query";
    }
    if (method == "GET") {
      cmd += " $header '$url'";
    } else {
      Map<String, dynamic> files = {};
      String postData = "-d ''";
      if (data != null) {
        if (data is FormData) {
          FormData fdata = data as FormData;
          for (var element in fdata.files) {
            MultipartFile file = element.value;
            files[element.key] = "@${file.filename}";
          }
          for (var element in fdata.fields) {
            files[element.key] = element.value;
          }
          if (files.isNotEmpty) {
            postData = files
                .map((key, value) => MapEntry(key, "-F '$key=$value'"))
                .values
                .join(" ");
          }
        } else if (data is Map<String, dynamic>) {
          files.addAll(data);

          if (files.isNotEmpty) {
            postData = "-d '${json.encode(files).toString()}'";
          }
        }
      }

      String method = this.method.toString();
      cmd += " -X $method $postData $header '$url'";
    }

    return cmd;
  }
}

class AuthToken implements Decoder<AuthToken> {
  String? accessToken;
  String? refreshToken;
  int? expiredTime;

  AuthToken({this.accessToken, this.refreshToken, this.expiredTime});

  @override
  AuthToken decode(dynamic data) {
    expiredTime = data['expired_time'];
    return this;
  }

  Future startRefreshToken() async {
    await Future.delayed(const Duration(seconds: 5));
    // assign new access token
    accessToken = '';
  }

  bool isExpired() {
    return false;
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  final APIClient client;
  AuthToken token;

  AuthInterceptor(this.client, this.token);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authorize = options.extra[RequestExtraKeys.authorize] ?? false;
    if (!authorize) {
      return super.onRequest(options, handler);
    }
    if (token.isExpired()) {
      client.instance.lock();
      debugPrint('Lock request for refreshing token...');
      await token.startRefreshToken();
      client.instance.unlock();
      debugPrint('Refresh token completed!');
    }
    if (token.accessToken != null) {
      options.headers.addAll({
        'id-token': token.accessToken,
        'x-api-key': "7351252421522e1ea2182d5790d8f67c",
      });
    }

    final curl = options.toCurlCmd();
    if (kDebugMode) {
      print("Curl: $curl");
    }
    return super.onRequest(options, handler);
  }
}
