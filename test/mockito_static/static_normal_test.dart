import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'static_normal_test.mocks.dart';

class Cat {
  String sound() => "Meow";
}

// Catクラスをモック化
@GenerateNiceMocks([MockSpec<Cat>()])

// Dioクラスをモック化
@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  test('Cat method test', () {
    final cat = MockCat();

    cat.sound();

    // 指定の処理が呼び出されかどうかを確認
    verify(cat.sound());
  });

  test('Dio method test', () {
    final dio = MockDio();

    when(dio.get("")).thenAnswer(
      (_) async => Response(requestOptions: RequestOptions()),
    );
    dio.get("");

    // 指定の処理が呼び出されかどうかを確認
    verify(dio.get(""));
  });
}
