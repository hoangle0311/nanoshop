import 'dart:convert';

import 'dart:developer' as developer;

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:nanoshop/src/core/constant/db_key/shared_paths.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/environment/app_environment.dart';

class CustomInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  CustomInterceptor(
    this._dio,
    this._sharedPreferences,
  );

  _print() {
    developer.log('-------------------');
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var response = err.response;

    var options = err.response!.requestOptions;

    int? statusCode = response?.statusCode;

    if (response == null) {
      _print();
      developer.log('# ERROR');
      developer.log('No Response');
      developer.log("Type Error : ${err.type.index}");
      developer.log(err.error);
      _print();
      super.onError(err, handler);
    }

    if (response != null) {
      _print();
      developer.log('# ERROR');
      developer.log(response.data);
      _print();
    }

    handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    _print();
    developer.log('# REQUEST');
    developer.log('--> ${options.method} ${options.baseUrl}${options.path}');
    _print();

    final String? tokenPrefs = _sharedPreferences.getString(SharedPaths.token);

    if (tokenPrefs == null) {
      developer.log('--> No Token');

      DateTime now = DateTime.now();

      String stringHash = now.millisecondsSinceEpoch.toString();

      var token = sha1.convert(
        utf8.encode(
          stringHash + Environment.token,
        ),
      );

      options.headers['token'] = token.toString();

      var tokenDio = Dio();
      tokenDio.options = _dio.options;

      tokenDio
          .get(
        ApiPath.token,
        queryParameters: {
          "string": stringHash,
        },
        options: Options(
          headers: options.headers,
        ),
      )
          .then((d) {
        developer.log('--> Request Token Succeed');
        developer.log('--> Continue to perform request');
        developer
            .log('--> ${options.method} ${options.baseUrl}${options.path}');

        _sharedPreferences.setString(
          SharedPaths.token,
          d.data['data']['token'],
        );

        handler.next(options);
      }).catchError((error, stackTrace) {
        developer.log(error);
        handler.reject(error, true);
      });
    } else {
      developer.log('--> Has Token');
      developer.log('--> $tokenPrefs');
      options.headers.addAll(
        {
          'token': tokenPrefs,
        },
      );

      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _print();
    developer.log('# RESPONSE');
    developer.log("--> ${response.statusCode}");
    // Bật lên để xem Raw Data
    // developer.log("--> ${response.data}");
    developer.log("END REQUEST <--");
    _print();
    super.onResponse(response, handler);
  }
}
