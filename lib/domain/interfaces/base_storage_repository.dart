import 'package:bling_challenge/domain/models/guess.dart';

abstract class StorageRepository {
  void addToSearchHistory(Guess guess);
  Future<List<Guess>?> getSearchHistory();
}
