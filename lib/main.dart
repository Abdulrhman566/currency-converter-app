import 'package:currency_converter/pages/exchange_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/exchange_cubit.dart';
import 'service/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ExchangeCubit(ApiService())..loadSavedCurrency(),
        child: const ExchangeScreen(),
      ),
    );
  }
}
