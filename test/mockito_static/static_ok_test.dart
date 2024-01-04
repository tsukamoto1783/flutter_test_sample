import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'static_ok_test.mocks.dart';

class Cat {
  static sound() => "Meow";
}

class CatWrapper {
  String soundWrapper() => Cat.sound();
}

class FluttertoastWrapper {
  Future<bool?> showToastWrapper() async =>
      await Fluttertoast.showToast(msg: "test");
}

// CatWrapperクラスをモック化
@GenerateNiceMocks([MockSpec<CatWrapper>()])

// FluttertoastWrapperクラスをモック化
@GenerateNiceMocks([MockSpec<FluttertoastWrapper>()])
void main() {
  test('Cat static method test', () {
    final cat = MockCatWrapper();

    cat.soundWrapper();

    // 指定の処理が呼び出されかどうかを確認
    verify(cat.soundWrapper()); // test ok
  });

  test('Fluttertoast static method test', () {
    final toast = MockFluttertoastWrapper();

    toast.showToastWrapper();

    // 指定の処理が呼び出されかどうかを確認
    verify(toast.showToastWrapper()); // test ok
  });
}
