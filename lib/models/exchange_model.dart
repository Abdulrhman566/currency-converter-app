class ExchangeModel {
  final String baseCode;
  final Map<String, dynamic> conversionRates;

  ExchangeModel({required this.baseCode, required this.conversionRates});

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      baseCode: json["base_code"],
      conversionRates: json["conversion_rates"],
    );
  }
}
