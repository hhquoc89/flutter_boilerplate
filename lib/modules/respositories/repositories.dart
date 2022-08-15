import 'package:flutter_boilerplate/api/api_client.dart';
import 'package:flutter_boilerplate/api/api_response.dart';
import 'package:flutter_boilerplate/api/api_route.dart';
import 'package:flutter_boilerplate/api/decodable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepositories {
  final String apiKey = "94f3c5b0c0011412ab4950d25a8cd4b9";
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  String _token = '';
  final String _status = '';
  late APIClient apiClient;
  Future<String> getToken() async {
    await apiClient
        .request<APIResponse<GetToken>>(
          route: APIRoute(APIType.getToken),
          extraPath: apiKey,
          create: (response) =>
              APIResponse(response: response, createObject: GetToken()),
        )
        .then((response) => _token = response.decodedData.toString());
    return _token;
  }

  Future<void> persistToken(String _token) async {
    await storage.write(key: 'token', value: _token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String userName, String password) async {
    await apiClient
        .request(
            route: APIRoute(APIType.validate),
            extraPath: apiKey,
            body: {
              "username": userName,
              "password": password,
              "request_token": _token
            },
            create: (_) => APIResponse<String>(response: _))
        .then((value) => _status);
    return _status;
  }
}

class GetToken extends Decoder<GetToken> {
  bool? success;
  String? expiresAt;
  String? requestToken;

  @override
  String toString() {
    return '$requestToken';
  }

  GetToken({this.success, this.expiresAt, this.requestToken});
  @override
  GetToken decode(Map<String, dynamic> json) => GetToken(
      success: json['success'],
      expiresAt: json['expires_at'],
      requestToken: json['request_token']);
}
