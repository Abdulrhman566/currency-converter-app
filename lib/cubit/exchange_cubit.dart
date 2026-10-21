
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/exchange_model.dart';
import '../service/api_service.dart';
import 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final ApiService apiService;

  ExchangeCubit(this.apiService) : super(ExchangeInitial());

  String selectedBaseCode = 'USD';

  Future<void> loadSavedCurrency() async {
    try {
      final pref = await SharedPreferences.getInstance();

      selectedBaseCode = pref.getString('base_code') ?? 'USD';

      await fetchRates();
    } catch (e) {
      if (!isClosed) {
        emit(ExchangeError(e.toString()));
      }
    }
  }

  Future<void> fetchRates() async {
    emit(ExchangeLoading());

    try {
      final ExchangeModel exchange =
          await apiService.fetchExchangeRates(selectedBaseCode);

      if (!isClosed) {
        emit(ExchangeSuccess(exchange));
      }
    } catch (e) {
      if (!isClosed) {
        emit(ExchangeError(e.toString()));
      }
    }
  }

  Future<void> changeCurrency(String currency) async {
    if (currency == selectedBaseCode) return;

    selectedBaseCode = currency;

    await fetchRates();

    final pref = await SharedPreferences.getInstance();

    await pref.setString('base_code', currency);
  }
}
