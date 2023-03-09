import 'package:bling_challenge/presentation/blocs/api_bloc.dart';
import 'package:bling_challenge/presentation/blocs/storage_bloc.dart';
import 'package:bling_challenge/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  init();
  runApp(const MyApp());
}

void init() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  await Hive.openBox<List<dynamic>>('searchHistory');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GuessBloc>(
          create: (context) => GuessBloc(),
        ),
        BlocProvider<StorageBloc>(
          create: (context) => StorageBloc(),
        ),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
