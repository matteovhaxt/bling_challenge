import 'package:bling_challenge/presentation/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GuessBloc>();

    final controller = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
              ),
              ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, child) => ElevatedButton(
                  onPressed: value.text == ''
                      ? null
                      : () => bloc.add(
                            AgeGuess(
                              name: controller.text,
                            ),
                          ),
                  child: BlocBuilder<GuessBloc, GuessState>(
                    bloc: bloc,
                    builder: (context, state) => Text(
                      '${bloc.state.result?.age}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
