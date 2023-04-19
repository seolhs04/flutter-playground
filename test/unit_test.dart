import 'package:flutter_app/utils/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });

  test('value should be decremented', () {
    final counter = Counter();

    counter.decrement();

    expect(counter.value, -1);
  });
}
