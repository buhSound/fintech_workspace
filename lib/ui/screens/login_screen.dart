import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context){
    final vm = context.watch<AuthViewModel>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fingerprint, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 24),
            if (vm.isLoading)
              const CircularProgressIndicator()
            else if (vm.isAutheticated)
              const Text('Acceso Autorizado!', style: TextStyle(color: Colors.green, fontSize: 18))
            else
              ElevatedButton.icon(
                  onPressed: () => context.read<AuthViewModel>().loginWithBiometrics(),
                  label: const Text('Ingresar con Huella'),
                  icon: const Icon(Icons.lock_open),
              ),
            if(vm.errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(vm.errorMessage!, style: const TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}