import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockito_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Cat>()])
class Cat {
  String sound() => "Meow";
  bool eatFood(String food, {bool? hungry}) => true;
  Future<void> chew() async => print("Chewing...");
  int walk(List<String> places) => 7;
  void sleep() {}
  void hunt(String place, String prey) {}
  int lives = 9;
}

void main() {
  group('verify', () {
    // モックオブジェクトを作成
    var cat = MockCat();
    test('verify test', () {
      cat.sound();

      // 指定の処理が呼び出されかどうかを確認
      verify(cat.sound()); // test OK
    });

    test('verify.called test', () {
      cat.sound();
      cat.sound();
      cat.sound();

      // 指定の処理が、指定した回数だけ呼び出されかどうかを確認
      verify(cat.sound()).called(3); // test OK

      // matcherも使用可能
      // verify(cat.sound()).called(greaterThan(3));
    });

    test('verifyInOrder test', () async {
      cat.sound();
      cat.sleep();
      await cat.chew();

      // 複数の処理が、特定の順序で実行されたことを確認
      verifyInOrder([cat.sound(), cat.sleep(), cat.chew()]); // test OK
      // verifyInOrder([cat.sound(), cat.chew(), cat.sleep()]); // test NG
    });

    test('verifyNever test', () {
      cat.sound();
      cat.sleep();

      // 指定の処理が、一度も呼ばれてないかを確認
      verifyNever(cat.chew()); // test OK
    });

    test('verifyZeroInteractions test', () {
      var cat2 = MockCat();

      // 指定の処理が、一度も呼ばれてないかを確認
      verifyZeroInteractions(cat2); // test OK
    });
  });

  group('verifyNoMoreInteractions verify', () {
    // モックオブジェクトを作成
    var cat = MockCat();

    test('test1', () {
      cat.sound();

      verify(cat.sound());

      verifyNoMoreInteractions(cat); // test OK
    });

    test('test2', () {
      cat.sound();
      verify(cat.sound());
      cat.sound();

      // verify後にcatが使用されているため、テストNG
      verifyNoMoreInteractions(cat);
    });

    test('test3', () {
      cat.sound();
      cat.sleep();

      verify(cat.sound());

      // cat.sleep()に対するverifyが実行されておらず、catが使用された状態のため、（cat.sleep()が検証対象から除外されていない）テストNG
      verifyNoMoreInteractions(cat);
    });
  });

  group('when test', () {
    var cat = MockCat();

    test('when test1', () {
      // スタブ化せずに呼び出すと、デフォルト値が返される
      expect(cat.sound(), equals("")); // test OK
    });
    // test('when test2', () {
    //   when(cat.sound());
    //   // whenだけだと、デフォルト値が返される
    //   expect(cat.sound(), equals("")); // test OK
    // });
    test('when.thenReturn test', () {
      when(cat.sound()).thenReturn("Hoge");

      expect(cat.sound(), equals("Hoge")); // test OK
    });
    test('when.thenThrow test', () {
      when(cat.lives).thenThrow(RangeError('Boo'));
      expect(() => cat.lives, throwsRangeError); // test OK
    });
    test('when.thenAnswer test', () {
      var responses = ["Purr", "Meow"];
      when(cat.sound()).thenAnswer((_) => responses.removeAt(0));

      expect(cat.sound(), "Purr");
      expect(cat.sound(), "Meow");
    });
  });

  group('matchers test', () {
    var cat = MockCat();
    test('any matchers test', () {
      // 引数が何であっても、falseを返すように設定
      when(cat.eatFood(any, hungry: anyNamed('hungry'))).thenReturn(false);

      // さまざまな引数でメソッドを呼び出し、常にfalseが返されることを確認
      expect(cat.eatFood('fish', hungry: true), isFalse);
      expect(cat.eatFood('meat', hungry: false), isFalse);
      expect(cat.eatFood('vegetable'), isFalse);
    });
    test('argThat matcher', () {
      // 引数foodが'fish'である場合にのみ、trueを返すように設定
      // equalsやcontains等のmatcherを併用することも可能
      when(cat.eatFood(argThat(equals('fish')))).thenReturn(true);

      // 'fish'の引数でメソッドを呼び出し、trueが返されることを確認
      expect(cat.eatFood('fish'), isTrue);

      // 'meat'の引数でメソッドを呼び出しても、スタブ化されていないため初期値であるfalseが返されることを確認
      expect(cat.eatFood('meat'), isFalse);
    });

    test('captureAny matchers', () {
      var cat = MockCat();
      cat.eatFood('fish');
      cat.eatFood('meat');

      expect(verify(cat.eatFood(captureAny)).captured, ["fish", "meat"]);
    });
  });
}
