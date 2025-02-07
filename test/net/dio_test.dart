import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:bounty_hunter/net/net.dart';
import 'package:bounty_hunter/shop/models/user_entity.dart';
import 'package:test/test.dart';

void main() {
  group('dio_test', () {
    Dio dio;
    setUp(() {
      /// 测试配置
      dio = DioUtils.instance.dio;
      dio.options.baseUrl = 'https://api.github.com/';
    });
    
    test('getUsers', () async {
      await DioUtils.instance.requestNetwork<UserEntity>(
        Method.get, HttpApi.users, 
        onSuccess: (data) {
          expect(data?.name, '大色玩');
        },
        onError: (code, msg) {
          debugPrint('$code, $msg');
        }
      );
    });
  });
}
