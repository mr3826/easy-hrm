import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import '../utils/app_string.dart';

class ExceptionHelper {
  ExceptionHelper._();

  static errorHandler({required OperationException exception,required String methodName}) async {
    if (exception.graphqlErrors.isNotEmpty) {
      log("Method Name ::: $methodName : Method: ${exception.graphqlErrors[0].path} Code:${exception.graphqlErrors[0].extensions?['code']}", error: exception.graphqlErrors[0].message);
      showErrorMessage(message: exception.graphqlErrors[0].message);
    } else {
      log("$methodName ::: ",error: "$exception");
      showErrorMessage(message: AppString.error_text);
    }
  }
}
