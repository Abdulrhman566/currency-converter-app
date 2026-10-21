# 💱 Currency Converter App

A modern currency exchange application built with **Flutter** that allows users to explore exchange rates between different currencies using the ExchangeRate API.

The app uses **Cubit** for state management, **Dio** for API requests, and **SharedPreferences** to save the user's selected base currency.

## ✨ Features

- 🌍 **Live Exchange Rates:** Fetch exchange rates for multiple currencies.
- 💱 **Base Currency Selection:** Choose your preferred base currency.
- 🔍 **Currency Search:** Search for currencies by their currency codes, such as USD, EGP, and EUR.
- 🔄 **Refresh Rates:** Fetch the latest available exchange rates.
- 💾 **Save Preferences:** Remember the selected base currency using SharedPreferences.
- ⚡ **State Management:** Manage loading, success, and error states using Cubit.
- 🎨 **Modern UI:** Clean and user-friendly interface built with Flutter.
- ⚠️ **Error Handling:** Handle network errors and API failures.

## 🛠️ Technologies Used

- **Flutter & Dart** — Application development.
- **Dio** — HTTP client for API requests.
- **Cubit (flutter_bloc)** — State management.
- **SharedPreferences** — Local storage for the selected currency.
- **ExchangeRate API** — Exchange-rate data source.

## 📂 Project Structure

```text
lib/
├── cubit/
│   ├── exchange_cubit.dart
│   └── exchange_state.dart
├── models/
│   └── exchange_model.dart
├── service/
│   └── api_service.dart
├── screens/
│   └── exchange_screen.dart
└── main.dart
```

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git https://github.com/Abdulrhman566/currency-converter-app
cd currency_converter
```

Replace `YOUR_REPOSITORY_URL` with your GitHub repository URL.

### 2. Install Dependencies

```bash
flutter pub get
```

Or install the required packages individually:

```bash
flutter pub add dio
flutter pub add flutter_bloc
flutter pub add shared_preferences
```

### 3. Configure the API

Get an API key from [ExchangeRate API](https://www.exchangerate-api.com/) and configure it in your `ApiService`.

The API endpoint follows this format:

```text
https://v6.exchangerate-api.com/v6/YOUR_API_KEY/latest/USD
```

Replace `YOUR_API_KEY` with your API key. Avoid committing private credentials to a public GitHub repository.

### 4. Run the Application

```bash
flutter run
```

## 🔄 How It Works

1. `BlocProvider` creates the `ExchangeCubit`.
2. The Cubit loads the previously selected currency from SharedPreferences.
3. `ApiService` uses Dio to request exchange-rate data from the API.
4. `ExchangeModel` converts the JSON response into Dart objects.
5. The Cubit emits loading, success, or error states.
6. `BlocBuilder` updates the UI according to the current state.
7. When the user selects another base currency, the app fetches its rates and saves the selection.

## 📊 Example

If the selected base currency is USD, the app displays the available exchange rates, including:

- **USD:** United States Dollar
- **EGP:** Egyptian Pound
- **EUR:** Euro
- **GBP:** British Pound

The displayed rates indicate how much of each target currency corresponds to one unit of the selected base currency.

## 🔮 Future Improvements

- Add an amount input field for direct currency conversion.
- Display currency names and country flags.
- Add a favorites list for frequently used currencies.
- Show the last update time for exchange rates.
- Cache the latest rates for offline access.
- Add conversion history.

## 🙏 Acknowledgements

Exchange-rate data is provided by [ExchangeRate API](https://www.exchangerate-api.com/).

---

**Developed with Flutter 💙**
