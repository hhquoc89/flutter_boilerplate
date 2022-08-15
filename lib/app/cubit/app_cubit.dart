import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api_client.dart';
import '../../api/interceptors/auth_interceptor.dart';
import '../../api/interceptors/error_interceptor.dart';
import '../../api/interceptors/response_interceptor.dart';
import '../../localizations/app_language.dart';
import '../../styles.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppStyles styles = DefaultAppStyles();
  AppLanguage language = AppLanguage();
  APIClient apiClient = APIClient();

  AppCubit(AppState state) : super(AppInitial());

  void changeStyle(AppStyles styles) {
    this.styles = styles;
    emit(AppChangeStyleSuccess());
  }

  Future<void> fetchLocale() async {
    await language.fetchLocale();
    emit(AppLanguageFetchLocaleCompleted(language.currentLocale));
  }

  Future<void> changeLanguage(String locale) async {
    await language.changeLanguage(locale);
    emit(AppLanguageFetchLocaleCompleted(Locale(locale)));
  }

  void initInterceptors({String? accessToken}) {
    AuthToken? localAuthToken;
    if (apiClient.instance.interceptors.isNotEmpty) {
      final authInterceptor =
          apiClient.instance.interceptors.first as AuthInterceptor;
      localAuthToken = authInterceptor.token;
      apiClient.instance.interceptors.clear();
    }

    ///auth token is always the firs interceptor for easily searching
    final AuthToken authToken = localAuthToken ?? AuthToken();
    if (accessToken != null) {
      authToken.accessToken = accessToken;
    }

    final AuthInterceptor authInterceptor =
        AuthInterceptor(apiClient, authToken);
    apiClient.instance.interceptors.add(authInterceptor);
    apiClient.instance.interceptors.addAll([
      LogInterceptor(
          responseBody: true, requestBody: true, responseHeader: false),
      ErrorInterceptor(apiClient,
          unauthorizedCallback: onLogout,
          onErrorCallback: onErrorCallback,
          onNetworkErrorCallback: onNetworkErrorCallback),
      ResponseInterceptor()
    ]);
  }

  void onLogout() {}

  void onErrorCallback(DioErrorType type) {
    if (type == DioErrorType.connectTimeout ||
        type == DioErrorType.receiveTimeout ||
        type == DioErrorType.sendTimeout) {
      emit(TimeOutRequest());
    }
  }

  void onNetworkErrorCallback(DioErrorType type) {
    emit(NoFoundNetwork());
  }
}


