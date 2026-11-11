import 'package:fintech_workspace/viewmodels/subscription_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/mock_data.dart';
import '../widgets/subscription_card.dart';
import 'subscription_detail_screen.dart';
import '../../viewmodels/auth_viewmodel.dart';

import 'add_subscription_screen.dart';

class MasterListScreen extends StatelessWidget{
    const MasterListScreen({super.key});

    @override 
    Widget build(BuildContext context){
        final subscriptionVM = context.watch<SubscriptionViewModel>();
        final subscriptions = subscriptionVM.subscriptions;
        final totalGasto = subscriptionVM.totalMonthlyCost;

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
                            itemCount: subscriptions.length,
                            itemBuilder: (context, index) {
                                final subscription = subscriptions[index];
                                
                                return Dismissible(
                                    key: Key(subscription.id),
                                    direction: DismissDirection.endToStart,
                                    
                                    background: Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.only(right: 24.0),
                                        margin: const EdgeInsets.only(bottom: 16.0),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context). colorScheme.error,
                                            borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: const Icon(Icons.delete, color: Colors.white, size: 28),
                                    ),
                                    
                                    onDismissed: (direction) {
                                        context.read<SubscriptionViewModel>().removeSubscription(subscription.id);

                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text('${subscription.name} eliminada'),
                                                action: SnackBarAction(
                                                    label: 'Deshacer',
                                                    onPressed: () {
                                                        context.read<SubscriptionViewModel>().addSubscription(subscription);
                                                    },
                                                ),
                                            ),
                                        );
                                    },
                                    child: SubscriptionCard(
                                        subscription: subscription,
                                        onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => SubscriptionDetailScreen(
                                                        subscription: subscription,
                                                    )
                                                )
                                            );
                                        }
                                    )
                                );
                            },
                        ),
                    ),
                ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddSubscriptionScreen(),
                        ),
                    );
                },
                icon: const Icon(Icons.add),
                label: const Text('Nueva'),
            ),
        );
    }
}


