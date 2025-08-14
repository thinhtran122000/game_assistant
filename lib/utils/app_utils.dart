import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppUtils {
  static final dio = Dio();
  static Future<bool> checkValidUrl(String url) async {
    try {
      final response = await dio.head(url);
      return response.statusCode != 404;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      }
      return true;
    }
  }

  static String proxyImageUrl(String originalUrl) => 'https://images.weserv.nl/?url=${Uri.encodeComponent(originalUrl)}';

  static String removeSpecificSymbols(String message) {
    return message.replaceAll(RegExp(r'[*#\[]'), '').replaceAll(']', ':').replaceAll('(', ' ').replaceAll(')', '');
  }
}
