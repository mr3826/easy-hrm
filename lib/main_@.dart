// /*
// Folder Structure:
// bash
// Copy code
// SOLID -principal
//home_module
// ├── /data
// │   ├── /models
// │   │   └── home_data_model.dart
// │   ├── /services
// │   │   └── home_api_service.dart
// │   ├── /repositories
// │       └── home_repository.dart
// ├── /domain
// │   ├── /entities
// │   │   └── home_entity.dart
// │   ├── /repositories
// │       └── home_repository_contract.dart
// │   └── /usecases
// │       └── fetch_home_data.dart
// ├── /application
// │   └── home_controller.dart
// 1. /data/models/home_data_model.dart
// dart
// Copy code
//
// class HomeDataModel {
//   final int id;
//   final String title;
//
//   HomeDataModel({required this.id, required this.title});
//
//   // Factory method for converting JSON to model
//   factory HomeDataModel.fromJson(Map<String, dynamic> json) {
//     return HomeDataModel(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
//
//   // Convert model to domain entity
//   Map<String, dynamic> toEntity() {
//     return {
//       'id': id,
//       'title': title,
//     };
//   }
// }
// 2. /data/services/home_api_service.dart
// dart
// Copy code
// import 'package:dio/dio.dart';
//
// class HomeApiService {
//   final Dio dio;
//
//   HomeApiService(this.dio);
//
//   Future<List<Map<String, dynamic>>> fetchHomeData() async {
//     final response = await dio.get('/home');
//     return (response.data as List).map((e) => e as Map<String, dynamic>).toList();
//   }
// }



// 3. /data/repositories/home_repository.dart
// dart
// Copy code
// import '../../domain/entities/home_entity.dart';
// import '../../domain/repositories/home_repository_contract.dart';
// import '../services/home_api_service.dart';
// import '../models/home_data_model.dart';
//
// class HomeRepository implements HomeRepositoryContract {
//   final HomeApiService apiService;
//
//   HomeRepository(this.apiService);
//
//   @override
//   Future<List<HomeEntity>> getHomeData() async {
//     final data = await apiService.fetchHomeData();
//     return data.map((json) => HomeDataModel.fromJson(json)).map((model) {
//       return HomeEntity(
//         id: model.id,
//         title: model.title,
//       );
//     }).toList();
//   }
// }



// 4. /domain/entities/home_entity.dart
// dart
// Copy code
// class HomeEntity {
//   final int id;
//   final String title;
//
//   HomeEntity({required this.id, required this.title});
// }
// 5. /domain/repositories/home_repository_contract.dart
// dart
// Copy code
// import '../entities/home_entity.dart';
//
// abstract class HomeRepositoryContract {
//   Future<List<HomeEntity>> getHomeData();
// }
// 6. /domain/usecases/fetch_home_data.dart
// dart
// Copy code
// import '../entities/home_entity.dart';
// import '../repositories/home_repository_contract.dart';
//
// class FetchHomeData {
//   final HomeRepositoryContract repository;
//
//   FetchHomeData(this.repository);
//
//   Future<List<HomeEntity>> execute() async {
//     return await repository.getHomeData();
//   }
// }
// 7. /application/home_controller.dart
// dart
// Copy code
// import '../domain/entities/home_entity.dart';
// import '../domain/usecases/fetch_home_data.dart';
//
// class HomeController {
//   final FetchHomeData fetchHomeData;
//
//   // State management variables (if needed)
//   List<HomeEntity> homeData = [];
//   bool isLoading = false;
//
//   HomeController(this.fetchHomeData);
//
//   Future<void> loadHomeData() async {
//     try {
//       isLoading = true;
//       homeData = await fetchHomeData.execute();
//     } catch (error) {
//       // Handle errors (logging, etc.)
//       print("Error loading home data: $error");
//     } finally {
//       isLoading = false;
//     }
//   }
// }*/
