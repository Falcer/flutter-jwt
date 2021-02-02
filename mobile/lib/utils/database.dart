import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void setupDatabase() async {
  await Hive.initFlutter();
  await Hive.openBox('auth');
}
