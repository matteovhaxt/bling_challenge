import 'dart:convert';
import 'dart:io';

import 'package:bling_challenge/data/sources/api.dart';
import 'package:bling_challenge/domain/interfaces/base_api_repository.dart';
import 'package:bling_challenge/domain/models/guess.dart';
import 'package:http/http.dart' as http;

class HttpApiRepository implements ApiRepository {
  HttpApiRepository({
    required this.api,
    required this.client,
  });

  final Api api;
  final http.Client client;

  @override
  Future<Guess> getGuess(String name) => _getData(
        uri: api.guess(name),
        builder: (json) => Guess.fromJson(json as Map<String, dynamic>),
      );

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 404:
          throw Exception("not-found");
        default:
          throw Exception("unknown");
      }
    } on SocketException catch (_) {
      throw "no-internet-connection";
    }
  }
}
