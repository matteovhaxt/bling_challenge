import 'package:bling_challenge/domain/interfaces/base_storage_repository.dart';
import 'package:bling_challenge/domain/models/guess.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageRepository implements StorageRepository {
  @override
  void addToSearchHistory(Guess guess) async {
    try {
      final Box<List<dynamic>> searchHistory = await Hive.box('searchHistory');

      var history = searchHistory.get('history');

      if (history == null) {
        history = <Map<String, dynamic>>[];
      }

      history.add(
        guess.toJson(),
      );

      await searchHistory.put(
        'history',
        history,
      );
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<Guess>?> getSearchHistory() async {
    try {
      final Box<List<dynamic>> searchHistory = await Hive.box('searchHistory');

      final history = searchHistory.get('history');

      if (history == null) {
        return [];
      }

      final result = history
          .toList()
          .map(
            (json) => Guess.fromJson(json),
          )
          .toList();

      return result;
    } catch (error) {
      throw Exception(error);
    }
  }
}
