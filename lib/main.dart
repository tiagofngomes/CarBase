import 'package:flutter/material.dart';

import 'app/app.dart';
import 'data/local/app_database.dart';
import 'data/local/carbase_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = CarBaseRepository(AppDatabase());
  final initialData = await repository.initialize();
  runApp(CarBaseApp(repository: repository, initialData: initialData));
}
