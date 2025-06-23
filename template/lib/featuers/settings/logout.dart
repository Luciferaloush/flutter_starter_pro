// import 'package:flutter/material.dart';
// import '../../../core/utils/app_shared_preferences.dart';
//
// class LogoutScreen extends StatelessWidget {
//   const LogoutScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Logout'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await AppPreferences().clearExceptCredentials();
//             context.pushNamedAndRemoveUntil('/');
//           },
//           child: const Text('Logout'),
//         ),
//       ),
//     );
//   }
// }
