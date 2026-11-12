import 'package:fintech_workspace/domain/models/subscription.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/secure_storage_service.dart';
import 'services/biometric_auth_service.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'ui/screens/login_screen.dart';
import 'services/device_interop_service.dart';
import 'ui/screens/root_screen.dart';
import 'viewmodels/subscription_viewmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SubscriptionAdapter());
  final subscriptionBox = await Hive.openBox<Subscription>('subscriptionsBox');

  runApp(FintechApp(subscriptionBox: subscriptionBox));
}

class FintechApp extends StatelessWidget{
  final Box<Subscription> subscriptionBox;

  const FintechApp({super.key, required this.subscriptionBox});

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
            create: (_) => SubscriptionViewModel(box: subscriptionBox),
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