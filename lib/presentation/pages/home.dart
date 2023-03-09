import 'package:bling_challenge/presentation/blocs/api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GuessBloc>();

    final controller = TextEditingController();

    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            child: FractionallySizedBox(
              widthFactor: .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<GuessBloc, GuessState>(
                    builder: (context, state) {
                      if (state.loading) {
                        return CircularProgressIndicator();
                      } else if (state.result != null) {
                        return Column(
                          children: [
                            Text(
                              '${state.result?.name}',
                              style: theme.textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'is most likely',
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${state.result?.age}',
                              style: theme.textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'years old.',
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        );
                      } else if (state.result == null) {
                        return Text(
                          'Type a name in the field below to get a guess on how old this person might be.',
                          style: theme.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        );
                      } else if (state.error != null) {
                        return Text(
                          'ERROR',
                        );
                      }
                      throw UnimplementedError();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: value.text == ''
                          ? null
                          : () {
                              bloc.add(
                                AgeGuess(
                                  name: controller.text,
                                ),
                              );
                              controller.clear();
                            },
                      child: Text(
                        'Make a guess',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
