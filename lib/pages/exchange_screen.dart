import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  final TextEditingController searchcont = TextEditingController();

  String searchQuery = '';

  @override
  void dispose() {
    searchcont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Currency Exchange',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF247CFF),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ExchangeCubit>().fetchRates();
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),

      body: BlocBuilder<ExchangeCubit, ExchangeState>(
        builder: (context, state) {
          // Loading State
          if (state is ExchangeLoading || state is ExchangeInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error State
          if (state is ExchangeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),

                  const SizedBox(height: 15),

                  Text(state.message, textAlign: TextAlign.center),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {
                      context.read<ExchangeCubit>().fetchRates();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          // Success State
          if (state is ExchangeSuccess) {
            final exchange = state.exchangeModel;

            final currencies = exchange.conversionRates.keys.toList()..sort();

            final filteredCurrencies = currencies.where((currency) {
              return currency.toLowerCase().contains(searchQuery.toLowerCase());
            }).toList();

            return Column(
              children: [
                // Base Currency Selection
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF247CFF),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Base Currency',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),

                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currencies.contains(exchange.baseCode)
                                ? exchange.baseCode
                                : null,
                            isExpanded: true,
                            items: currencies.map((currency) {
                              return DropdownMenuItem(
                                value: currency,
                                child: Text(currency),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<ExchangeCubit>().changeCurrency(
                                  value,
                                );
                              }
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        '1 ${exchange.baseCode} =',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Search
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: searchcont,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search currency...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // Currency List
                Expanded(
                  child: filteredCurrencies.isEmpty
                      ? const Center(child: Text('No currencies found'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredCurrencies.length,
                          itemBuilder: (context, index) {
                            final currency = filteredCurrencies[index];

                            final rate = exchange.conversionRates[currency];

                            return Card(
                              color: Colors.white,
                              elevation: 0,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Color(0xFFE8F1FF),
                                  child: Icon(
                                    Icons.currency_exchange,
                                    color: Color(0xFF247CFF),
                                  ),
                                ),
                                title: Text(
                                  currency,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('1 ${exchange.baseCode}'),
                                trailing: Text(
                                  (rate as num).toStringAsFixed(4),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF247CFF),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
