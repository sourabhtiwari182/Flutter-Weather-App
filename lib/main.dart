import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final String apiKey = "e64e1e38eb1628e831aa62f364c8be42";
  final TextEditingController _searchController = TextEditingController();

  String location = '';
  String weatherCondition = 'Enter a location';
  String temperature = '';
  String errorMessage = '';

  Future<void> fetchWeatherData(String city) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          location = data['name'];
          weatherCondition = data['weather'][0]['description'];
          temperature = '${data['main']['temp'].round()}°C';
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'Location not found. Please try again.';
          location = '';
          weatherCondition = '';
          temperature = '';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to connect. Please check your internet.';
        location = '';
        weatherCondition = '';
        temperature = '';
      });
    }
  }

  IconData _getWeatherIcon(String condition) {
    condition = condition.toLowerCase();
    if (condition.contains('clear')) return Icons.wb_sunny;
    if (condition.contains('cloud')) return Icons.cloud;
    if (condition.contains('rain')) return Icons.beach_access;
    if (condition.contains('snow')) return Icons.ac_unit;
    if (condition.contains('thunderstorm')) return Icons.flash_on;
    return Icons.cloud_queue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo.shade900,
              Colors.blue.shade600,
              Colors.cyan.shade400,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Weather Forecast',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Search Location',
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintText: 'Enter city name',
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.search, color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        fetchWeatherData(query);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 32),
                if (errorMessage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                else if (location.isNotEmpty)
                  Expanded(
                    child: WeatherCard(
                      city: location,
                      condition: weatherCondition,
                      temperature: temperature,
                      icon: _getWeatherIcon(weatherCondition),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String city;
  final String condition;
  final String temperature;
  final IconData icon;

  const WeatherCard({
    Key? key,
    required this.city,
    required this.condition,
    required this.temperature,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          Text(
            city,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            temperature,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            condition.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              letterSpacing: 1.5,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
