import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/cubit/quiz_cubit.dart';
import 'package:quiz_app/firebase_options.dart';

import 'start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..getQuestions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const StartScreen(),
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
