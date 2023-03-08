import 'package:bling_challenge/data/repositories/repository.dart';
import 'package:bling_challenge/data/sources/api.dart';
import 'package:bling_challenge/domain/models/guess.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

abstract class GuessEvent {}

class AgeGuess extends GuessEvent {
  AgeGuess({
    required this.name,
  });

  final String name;
}

class GuessState {
  GuessState({
    required this.result,
    required this.loading,
    required this.error,
  });
  Guess? result;
  bool loading = false;
  dynamic error;

  GuessState copyWith({
    Guess? result,
    bool? loading,
    dynamic error,
  }) =>
      GuessState(
        result: result ?? this.result,
        loading: loading ?? this.loading,
        error: error ?? this.error,
      );
}

class GuessBloc extends Bloc<GuessEvent, GuessState> {
  GuessBloc()
      : super(
          GuessState(
            result: null,
            loading: false,
            error: null,
          ),
        ) {
    final repository = HttpApiRepository(
      api: Api(),
      client: http.Client(),
    );
    on<AgeGuess>((event, emit) async {
      try {
        emit(
          state.copyWith(
            loading: true,
          ),
        );
        final result = await repository.getGuess(
          event.name,
        );
        emit(
          state.copyWith(
            result: result,
            loading: false,
          ),
        );
      } catch (error) {
        emit(
          state.copyWith(
            loading: false,
            error: error,
          ),
        );
      }
    });
  }
}
