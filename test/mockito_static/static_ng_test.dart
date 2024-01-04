import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'static_ng_test.mocks.dart';

class Cat {
  static sound() => "Meow";
}

// Catクラスをモック化
@GenerateNiceMocks([MockSpec<Cat>()])

// Fluttertoastクラスをモック化
@GenerateNiceMocks([MockSpec<Fluttertoast>()])

// @GenerateNiceMocks([MockSpec<Cat>()])
// class CatWrapper {
//   String soundWrapper() => Cat.sound();
// }

void main() {
  test('Cat static method test', () {
    final cat = MockCat();
    final cat2 = Cat();

    cat2.sound();

    // 指定の処理が呼び出されかどうかを確認
    verify(cat.sound()); // error
  });

  test('Fluttertoast static method test', () {
    final toast = MockFluttertoast();

    toast.toast();

    // 指定の処理が呼び出されかどうかを確認
    verify(toast.toast()); // error
  });
}
