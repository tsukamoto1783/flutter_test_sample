import 'package:flutter_test/flutter_test.dart';

void main() {
  print('main start');

  // 全テスト開始前に1回だけ実行される
  setUpAll(() {
    print('main setUpAll');
  });

  // 各テストケースの前に実行される
  setUp(() {
    print('main setUp');
  });

  // 各テストケースの後に実行される
  tearDown(() {
    print('main tearDown');
  });

  // 全テスト終了後に1回だけ実行される
  tearDownAll(() {
    print('main tearDownAll');
  });

  group('group1', () {
    print('group1 start');

    // グループ内の全テスト開始前に1回だけ実行される
    setUpAll(() {
      print('group1 setUpAll');
    });

    // グループ内の各テストケースの前に実行される
    setUp(() {
      print('group1 setUp');
    });

    // グループ内の各テストケースの後に実行される
    tearDown(() {
      print('group1 tearDown');
    });

    // グループ内の全テスト終了後に1回だけ実行される
    tearDownAll(() {
      print('group1 tearDownAll');
    });

    test('test1', () {
      print('test1');
    });

    test('test2', () {
      print('test2');
    });

    // 簡単な足し算テスト
    test('2 + 3 = 5', () {
      int result = 2 + 3;
      expect(result, equals(5));
    });

    print('group1 end');
  });

  print('main end');
}
