import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Dio Interceptor Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final dio = Dio();

              // Add interceptor
              dio.interceptors.add(
                InterceptorsWrapper(
                  onRequest: (options, handler) {

                    // Add headers or modify the request
                    options.headers['Content-Type'] = 'application/json';
                    options.headers['Authorization'] = 'Bearer your_token';
                    options.headers['User-Agent'] = 'getx-client';


                    // Log the request
                    print('Request: ${options.method} ${options.uri}');
                    print('Headers: ${options.headers}');
                    print('Body: ${options.data}');

                    return handler.next(options); // Continue
                  },
                  onResponse: (response, handler) {
                    // Log the response
                    print('Response: ${response.statusCode} ${response.data}');
                    return handler.next(response); // Continue
                  },
                  onError: (DioError e, handler) {
                    // Handle errors
                    print('Error: ${e.message}');
                    return handler.next(e); // Continue
                  },
                ),
              );

              try {
                final response = await dio.post(
                  'https://api.dev.payrun.app/auth/login',
                  data: {
                    "email": "rifat74@yopmail.com",
                    "password": "Test00@@"
                  },
                );
                print('Response data: ${response.data}');
              } catch (e) {
                print('Error: $e');
              }
            },
            child: Text('Send POST Request'),
          ),
        ),
      ),
    );
  }
}
