import 'package:flutter_test/flutter_test.dart';

void main() {
  group("テストグループ", () {
    test('テスト名', () {
      // テストしたい処理
      int result = 2 + 3;

      expect(result, 5);
    });
  });

  test(
    '足し算テスト',
    () {
      int result = 2 + 3;
      expect(result, 5);
    },
    testOn: 'mac-os', // このテストはVMプラットフォームでのみ実行される。
    timeout: Timeout(Duration(seconds: 2)), // テストが2秒以上かかった場合はテスト失敗。
    skip: false, // テストをスキップしない。
    tags: 'math', // このテストにmathタグを追加。
    onPlatform: {
      // 特定のプラットフォームでテストのタイムアウトを上書きする設定。
      'windows': Timeout(Duration(seconds: 3)),
      'linux': Timeout(Duration(seconds: 1)),
    },
    retry: 2, // テストが失敗した場合、2回まで再試行する。
  );

  test('equals sample', () {
    int actual = 5;
    int expected = 5;
    expect(actual, equals(expected));
  });

  test('contains sample', () {
    List<int> numbers = [1, 2, 3, 4, 5];
    int value = 3;
    expect(numbers, contains(value));
  });

  test('isEmpty sample', () {
    List<int> emptyList = [];
    expect(emptyList, isEmpty);
  });
}
