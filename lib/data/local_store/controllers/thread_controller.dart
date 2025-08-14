import 'dart:developer';

import 'package:game_assistant/data/local_store/constants.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThreadController {
  static late Box<ThreadModel> box;
  ThreadController();

  static Future<void> open() async {
    box = await Hive.openBox<ThreadModel>(BoxName.threadBox);
  }

  static List<ThreadModel> getThreads() => box.values.toList();

  static ThreadModel? getThreadDetails(ThreadModel thread) {
    final index = box.values.toList().indexWhere((element) => element.id == thread.id);
    return box.getAt(index);
  }

  static List<ThreadModel> createThread(ThreadModel thread) {
    try {
      final index = box.values.toList().indexWhere((element) => element.id == thread.id);
      if (index == -1) {
        box.add(thread);
      } else {
        null;
      }
      return box.values.toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static List<ThreadModel> deleteThread(ThreadModel thread) {
    final index = box.values.toList().indexWhere((element) => element.id == thread.id);
    box.deleteAt(index);
    return box.values.toList();
  }

  static Future<void> deleteThreads() async {
    await box.clear();
  }

  static Future<void> close() async {
    await box.close();
  }
}
