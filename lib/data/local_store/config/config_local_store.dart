import 'package:game_assistant/data/models/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> configLocalStore() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ThreadModelAdapter());
  Hive.registerAdapter(ToolResourcesAdapter());
  Hive.registerAdapter(CodeInterpreterAdapter());
  Hive.registerAdapter(VectorStoresAdapter());
  Hive.registerAdapter(FileSearchAdapter());
}
