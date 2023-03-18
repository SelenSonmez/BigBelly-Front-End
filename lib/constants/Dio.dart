import 'package:dio/dio.dart';

Dio dio = Dio(BaseOptions(
  baseUrl: 'http://18.184.145.252',
  validateStatus: (status) {
    if (status == null) return false;
    if (status >= 100 && status < 600)
      return true;
    else
      return false;
  },
));
