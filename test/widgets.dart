// import 'package:flutter/material.dart';

// class WeatherCard extends StatelessWidget {
//   final String city;
//   final String condition;
//   final String temperature;

//   const WeatherCard({
//     Key? key,
//     required this.city,
//     required this.condition,
//     required this.temperature,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 8.0,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             city,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Condition: $condition',
//             style: const TextStyle(fontSize: 18),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Temperature: $temperature',
//             style: const TextStyle(fontSize: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }
