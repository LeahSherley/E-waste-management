import 'package:dio/dio.dart';

class Direction{
  static const String _url = 'https://maps.googleapis.com/maps/api/directions/json?';
final Dio _dio;
Direction({required Dio dio}) : _dio = dio ?? Dio();
}