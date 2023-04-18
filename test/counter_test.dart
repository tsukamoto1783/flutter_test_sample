// Import the test package and Counter class
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_sample/counter.dart';

void main() {
  // 公式ドキュメントのテストコード
  group('Counter', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('value should be incremented', () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      final counter = Counter();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
