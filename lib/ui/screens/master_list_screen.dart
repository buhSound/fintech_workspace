import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/mock_data.dart';
import '../widgets/subscription_card.dart';
import 'subscription_detail_screen.dart';
import '../../viewmodels/auth_viewmodel.dart';

class MasterListScreen extends StatelessWidget{
    const MasterListScreen({super.key});

    @override 
    Widget build(BuildContext context){

        final int totalGasto = mockSubscriptions.fold<int>(
            0,
            (sum, item) => sum + item.monthlyCost
        );

        return Scaffold(
            appBar: AppBar(
                title: const Text(
                    'Mis Suscripciones', 
                    style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
                elevation: 0,
                actions: [
                    IconButton(
                        icon: const Icon(Icons.exit_to_app),
                        onPressed: () => context.read<AuthViewModel>().logout(),
                        tooltip: 'Cerrar Sesion',
                    ),
                ],
            ),
            body: Column(
                children: [
                    Container(
                        padding: const EdgeInsets.all(24.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                        ),
                        child: Column(
                            children: [
                                Text(
                                    'Gasto Mensual Estimado',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)
                                    )
                                ),
                                const SizedBox(height: 8),
                                Text(
                                    '\$ $totalGasto',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onPrimaryContainer
                                    )
                                ),
                            ],
                        ),
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            itemCount: mockSubscriptions.length,
                            itemBuilder: (context, index) {
                                final subscription = mockSubscriptions[index];

                                return SubscriptionCard(
                                    subscription: subscription,
                                    onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SubscriptionDetailScreen(
                                                    subscription: subscription
                                                ),
                                            ),
                                        );
                                    },
                                );
                            },
                        ),
                    ),
                ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    // TODO: Implementar vista para añadir suscripción
                },
                icon: const Icon(Icons.add),
                label: const Text('Nueva'),
            ),
        );
    }
}


