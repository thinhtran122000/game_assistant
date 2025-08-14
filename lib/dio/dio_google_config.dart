// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// @injectable
// class DioGoogleInfo {
//   Dio dio() {
//     final dio = Dio();
//     dio.options.contentType = Headers.jsonContentType;
//     dio.options.connectTimeout = const Duration(seconds: 60);
//     dio.options.receiveTimeout = const Duration(seconds: 60);
//     // dio.interceptors.add(DioQueueInterceptor());
//     dio.interceptors.add(PrettyDioLogger(
//       requestBody: true,
//       responseBody: true,
//       error: true,
//       requestHeader: false,
//       responseHeader: false,
//     ));
//     return dio;
//   }
// }
