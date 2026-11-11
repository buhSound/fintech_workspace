import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/secure_storage_service.dart';
import 'services/biometric_auth_service.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'ui/screens/login_screen.dart';
import 'services/device_interop_service.dart';
import 'ui/screens/root_screen.dart';
import 'viewmodels/subscription_viewmodel.dart';

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

          Provider<SecureStorageService>(
            create: (_) => SecureStorageService(),
          ),

          Provider<DeviceInteropService>(
            create: (_) => DeviceInteropService(),
          ),

          ChangeNotifierProvider<AuthViewModel>(
            create: (context) => AuthViewModel(
              biometricService: context.read<BiometricAuthService>(),
              secureStorage: context.read<SecureStorageService>(),
            ),
          ),

          ChangeNotifierProvider<SubscriptionViewModel>(
            create: (_) => SubscriptionViewModel(),
            ),
        ],
      child: MaterialApp(
        title: 'Fintech Workspace',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const RootScreen(),
      ),
    );
  }
}