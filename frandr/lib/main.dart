import 'package:flutter/material.dart';
import 'package:frandr/app.dart';
import 'package:frandr/displays/displays_state.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.instance.registerSingleton(DisplaysState());
  runApp(App());
}
