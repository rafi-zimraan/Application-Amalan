// import 'package:flutter/material.dart';
// import 'package:giveup/features/BottomTop/Bottom_top_component.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToHome();
//   }

//   _navigateToHome() async {
//     await Future.delayed(const Duration(seconds: 3), () {});
//     Navigator.pushReplacement(context,
//         MaterialPageRoute(builder: (context) => const BottomTopComponent()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       color: Colors.white,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // const Text(
//             //   'Welcome To giveUp',
//             //   style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
//             // ),
//             // const SizedBox(
//             //   height: 20,
//             // ),
//             Image.asset(
//               'lib/assets/icons/logo.png',
//               width: 200,
//               height: 200,
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
