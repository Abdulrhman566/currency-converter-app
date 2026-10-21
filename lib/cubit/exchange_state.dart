
import 'package:currency_converter/models/exchange_model.dart';

abstract class ExchangeState {}

class ExchangeInitial extends ExchangeState {}

class ExchangeLoading extends ExchangeState {}

class ExchangeSuccess extends ExchangeState {
  final ExchangeModel exchangeModel;

  ExchangeSuccess(this.exchangeModel);
}

class ExchangeError extends ExchangeState {
  final String message;

  ExchangeError(this.message);
}
