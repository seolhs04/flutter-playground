import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/models/webtoon_detail_model.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_unit_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('id로 웹툰 가져오기', () {
    final client = MockClient();
    const id = '790713';
    const url = '${ApiService.baseUrl}/$id';
    test('성공', () async {
      String body = jsonEncode({
        "title": "한국어",
        "about": "about test",
        "genre": "genre test",
        "age": "age test"
      });
      when(client.get(Uri.parse(url))).thenAnswer((_) async => http.Response(
            body,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            },
          ));
      expect(
          await ApiService.getToonById(id, client), isA<WebtoonDetailModel>());
    });
    test('실패', () {
      when(client.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      expect(ApiService.getToonById(id, client), throwsException);
    });
  });
}
