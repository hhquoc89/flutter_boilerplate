import 'package:flutter/material.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeStyleSuccess extends AppState {}

class AppLanguageFetchLocaleCompleted extends AppState {
  final Locale locale;
  AppLanguageFetchLocaleCompleted(this.locale);
}

class NoFoundNetwork extends AppState {}

class TimeOutRequest extends AppState {}
