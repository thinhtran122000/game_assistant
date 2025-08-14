// import 'dart:developer';

// import 'package:dio/dio.dart';

// class DioQueueInterceptor extends QueuedInterceptor {
//   // @override
//   // void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

//   //   super.onRequest(options, handler);
//   // }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     // log('\x1B[33m=> PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}?${response.requestOptions.queryParameters.entries.toList().map((entry) => '${entry.key}=${entry.value}').join('&')}\x1B[0m');
//     // log('\x1B[32m=> RESPONSE DATA: ${response.data}\x1B[0m');
//     super.onResponse(response, handler);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     switch (err.response?.statusCode) {
//       case 401:
//         // await storage.deleteAll();
//         // router.replaceAll([const AuthenticationRoute()]);
//         return super.onError(err, handler);

//       default:
//         return super.onError(err, handler);
//     }
//   }
// }
