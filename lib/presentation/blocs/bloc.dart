import 'package:bling_challenge/data/repositories/repository.dart';
import 'package:bling_challenge/data/sources/api.dart';
import 'package:bling_challenge/domain/models/guess.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

abstract class GuessEvent {}

class AgeGuess extends GuessEvent {
  AgeGuess({required this.name});

  final String name;
}

class GuessBloc extends Bloc<GuessEvent, Guess?> {
  GuessBloc() : super(null) {
    final repository = HttpApiRepository(
      api: Api(),
      client: http.Client(),
    );
    on<AgeGuess>((event, emit) async {
      try {
        final result = await repository.getGuess(
          event.name,
        );
        emit(result);
      } catch (error) {
        throw Exception(error);
      }
    });
  }
}
