import 'package:dio/dio.dart';
import 'package:movies_app/shared/constants.dart';
class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: BASE_URL, receiveDataWhenStatusError: true));
  }

  static Future<Response?> getData(
      {required String url, required Map<String, dynamic> query}) async {
    var data = await dio?.get(url, queryParameters: query).catchError((e) {
      print(e);
    });
    return data;
  }
}
