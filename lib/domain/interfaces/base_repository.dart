import 'package:bling_challenge/domain/models/guess.dart';

abstract class ApiRepository {
  Future<Guess> getGuess(String name);
}
