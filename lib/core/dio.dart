import 'package:dio/dio.dart';


class DioHelper {
  static late Dio dio;
  static Init_dio() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.tryon-store.xyz/api/v1',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,
        String? token
      }) async {

    dio.options.headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dio.get(url, queryParameters: query);
  }
  // Future<Response> getData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   String? token,
  // }) async {
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   try {
  //     return await dio.get(url, queryParameters: query);
  //   } catch (e) {
  //     if (e is DioError) {
  //       if (e.response != null) {
  //         // Handle other errors
  //         print('Dio error response:');
  //         print(e.response?.data);
  //         print(e.response?.statusCode);
  //       } else {
  //         // Handle network-related errors
  //         print('Dio network error:');
  //         print(e.message);
  //       }
  //
  //       if (e.response?.statusCode == 422) {
  //         final error = e.response?.data;
  //         final message = error["message"];
  //         print('Status code 422 error:');
  //         print(error);
  //         print(message);
  //       }
  //     }
  //     // Rethrow the error to handle it in the calling code if needed
  //     throw e;
  //   }
  // }



  static Future<Response> postData(
      {required String url,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data,
        String? token
      }) async {
    dio.options.headers = {
      'Authorization': "Bearer $token",
      // 'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {required String url,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data,
        String? token}) async {
    dio.options.headers = {
      'Authorization': token,
      // 'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return dio.delete(url, queryParameters: query);

  }

}
