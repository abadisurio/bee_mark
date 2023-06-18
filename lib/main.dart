import 'package:bee_mark/database/db_beemark.dart';
import 'package:bee_mark/global_bloc/book/book_bloc.dart';
import 'package:bee_mark/screen/home/view/home.dart';
import 'package:bee_mark/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: routeGenerator,
      home: FutureBuilder(future: Future(
        () async {
          await BeeMarkDB.init();
        },
      ), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return BlocProvider(
          create: (context) => BookBloc(),
          child: const Home(),
        );
      }),
    );
  }
}
