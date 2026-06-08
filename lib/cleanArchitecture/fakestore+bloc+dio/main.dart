// Import Flutter material
import 'package:flutter/material.dart';
// Import flutter_bloc
import 'package:flutter_bloc/flutter_bloc.dart';
// Import Dio HTTP client
import 'package:dio/dio.dart';

// Import data layer
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';

// Import domain layer
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/get_products_usecase.dart';

// Import presentation layer
import 'presentation/bloc/product_bloc.dart';
import 'presentation/pages/product_list_page.dart';

// ============== MAIN ENTRY POINT ==============
// This function runs when app starts
void main() {
  // Pass MyApp widget to Flutter
  runApp(const MyApp());
}

// ============== ROOT WIDGET ==============
// MyApp = root of entire application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ============== SETUP: DIO HTTP CLIENT ==============
    // Create Dio instance for making HTTP requests
    final dio = Dio();
    // ============== SETUP: DATA SOURCE ==============
    // Create ProductRemoteDataSourceImpl
    // This handles all API calls via Dio
    final remoteDataSource = ProductRemoteDataSourceImpl(dio);
    // ============== SETUP: REPOSITORY ==============
    // Create ProductRepositoryImpl
    // This is middleman between domain and data
    final repository = ProductRepositoryImpl(remoteDataSource);
    // ============== SETUP: USE CASES ==============
    // Create GetProductsUseCase
    final getProductsUseCase = GetProductsUseCase(repository);
    // Create GetProductsByCategoryUseCase
    final getProductsByCategoryUseCase =
    GetProductsByCategoryUseCase(repository);

    // ============== SETUP: MATERIAL APP ==============
    // MaterialApp = root of Flutter app
    return MaterialApp(
      title: 'FakeStore Products',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // ============== SETUP: BLOC PROVIDER ==============
      // BlocProvider = makes BLoC available to all children
      home: BlocProvider(
        // Create BLoC with injected use cases
        create: (context) => ProductBloc(
          getProductsUseCase: getProductsUseCase,
          getProductsByCategoryUseCase: getProductsByCategoryUseCase,
        ),
        // Child widget that can access BLoC
        child: const ProductListPage(),
      ),
    );
  }
}
