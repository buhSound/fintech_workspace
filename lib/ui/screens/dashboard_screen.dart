import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mi Billetera'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => context.read<AuthViewModel>().logout(),
              tooltip: 'Cerrar sesion',
            ),
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet, size: 80, color: Colors.blueAccent),
              SizedBox(height: 24),
              Text(
                '¡Bienvenido al Dashboard!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Tu sesion esta protegida y activa.'),
            ],
          ),
        ),
    );
  }
}