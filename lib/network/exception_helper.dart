import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';

class ExceptionHelper {
  ExceptionHelper._();

  static errorHandler({required OperationException exception}) async {
    if (exception.graphqlErrors.isNotEmpty) {
      showErrorMessage(message: exception.graphqlErrors.toString());
    } else {
      
    }
  }
}
