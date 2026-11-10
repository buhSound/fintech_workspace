import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/biometric_auth_service.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'ui/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FintechApp());
}

class FintechApp extends StatelessWidget{
  const FintechApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
        providers: [
          Provider<BiometricAuthService>(
            create: (_) => BiometricAuthService(),
          ),

          ChangeNotifierProvider<AuthViewModel>(
            create: (context) => AuthViewModel(
                biometricService: context.read<BiometricAuthService>(),
            ),
          ),
        ],
      child: MaterialApp(
        title: 'Fintech Workspace',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}