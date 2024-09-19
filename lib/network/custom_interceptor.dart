import 'package:dio/dio.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log request details
    print('Request [${options.method}] => PATH: ${options.path}');
    print('Headers: ${options.headers}');
    print('Body: ${options.data}');

    // Continue with the request
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response details
    print(
        'Response [${response.statusCode}] => DATA: ${response.data['message']}');

    // Continue with the response
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log error details
    print(
        'Error [${err.response?.statusCode}] => MESSAGE: ${err.message} server err ${err.response?.data['message']} ');
    showErrorMessage(message: "${err.response?.data['message']}");
    // Continue with the error
    handler.next(err);
  }
}
