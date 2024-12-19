import 'package:dio/dio.dart';
import 'package:payrun_mobile/app/global/services/rest_service.dart';
import 'package:payrun_mobile/app/global/services/webSocket_service.dart';
import 'graphQL_service.dart';

class ApiService {
  final RestService _restService;
  final GraphQLService _graphQLService;
  final WebSocketService _webSocketService;

  ApiService({
    required RestService restService,
    required GraphQLService graphQLService,
    required WebSocketService webSocketService,
  })  : _restService = restService,
        _graphQLService = graphQLService,
        _webSocketService = webSocketService;

  // Method for making a REST API call # GET
  Future<Response?> makeGetApiCall(String endpoint) async {
    try {
      return await _restService.get(endpoint);
    } catch (e) {
      print('Error in API call: $e');
    }
    return null;
  }

  // Method for making a REST API call # POST
  Future<Response?> makePostApiCall(String endpoint, dynamic data) async {
    try {
      return await _restService.post(endpoint, data);
    } catch (e) {
      print('Error in API call: $e');
    }
    return null;
  }

  // Method for making a GraphQL query
  Future<void> makeGraphQLQuery(String query) async {
    try {
      final result = await _graphQLService.query(query);
      if (result.hasException) {
        print('GraphQL Error: ${result.exception}');
      } else {
        print('GraphQL Response: ${result.data}');
      }
    } catch (e) {
      print('Error in GraphQL query: $e');
    }
  }

  // Method for making a GraphQL mutation
  Future<void> makeGraphQLMutation(String mutation) async {
    try {
      final result = await _graphQLService.mutate(mutation);
      if (result.hasException) {
        print('GraphQL Error: ${result.exception}');
      } else {
        print('GraphQL Mutation Response: ${result.data}');
      }
    } catch (e) {
      print('Error in GraphQL mutation: $e');
    }
  }

  // Method for subscribing to WebSocket updates
  void subscribeToWebSocket(String subscription) {
    _webSocketService.subscribe(subscription).listen((data) {
      print('WebSocket Data: $data');
    });
  }
}

// Example code to call api
// ApiService _apiService=ApiService()
// void fetchGraphQLData() async {
//   const String query = """
//       query getUserData {
//         user {
//           id
//           name
//           email
//         }
//       }
//     """;
//   try {
//     final result = await _apiService.query(query);
//     if (result.hasException) {
//       print('GraphQL Error: ${result.exception}');
//     } else {
//       print('GraphQL Response: ${result.data}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
//
// void subscribeToRealTimeData() {
//   const String subscription = """
//       subscription onUserDataUpdated {
//         user {
//           id
//           name
//           email
//         }
//       }
//     """;
//   _apiService.subscribe(subscription).listen((data) {
//     print('Real-time data: $data');
//   });
// }
//
// void fetchRestData() async {
//   try {
//     final response = await _apiService.get('/endPoint');
//     print('REST Response: ${response.data}');
//   } catch (e) {
//     print('Error: $e');
//   }
// }