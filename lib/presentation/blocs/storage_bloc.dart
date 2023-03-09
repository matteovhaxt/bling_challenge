import 'package:bling_challenge/data/repositories/storage_repository.dart';
import 'package:bling_challenge/domain/models/guess.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StorageEvent {}

class AddToSearchHistory extends StorageEvent {
  AddToSearchHistory({
    required this.guess,
  });

  final Guess guess;
}

class GetSearchHistory extends StorageEvent {}

class StorageState {
  StorageState({
    required this.result,
    required this.loading,
    required this.error,
  });
  List<Guess>? result;
  bool loading = false;
  dynamic error;

  StorageState copyWith({
    List<Guess>? result,
    bool? loading,
    dynamic error,
  }) =>
      StorageState(
        result: result ?? this.result,
        loading: loading ?? this.loading,
        error: error ?? this.error,
      );
}

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  StorageBloc()
      : super(
          StorageState(
            result: null,
            loading: false,
            error: null,
          ),
        ) {
    final repository = HiveStorageRepository();
    on<AddToSearchHistory>(
      (event, emit) async {
        try {
          emit(
            state.copyWith(
              loading: true,
            ),
          );
          repository.addToSearchHistory(
            event.guess,
          );
          emit(
            state.copyWith(
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
      },
    );
    on<GetSearchHistory>(
      (event, emit) async {
        try {
          emit(
            state.copyWith(
              loading: true,
            ),
          );
          final result = await repository.getSearchHistory();

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
      },
    );
  }
}
