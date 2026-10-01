import 'package:flutter/material.dart';

import '../../domain/models/mock_data.dart';
import '../widgets/subscription_card.dart';
import 'subscription_detail_screen.dart';

class MasterListScreen extends StatelessWidget{
    const MasterListScreen({super.key});

    @override 
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: const Text(
                    'Mis Suscripciones', 
                    style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
                elevation: 0,
            ),
            body: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemCount: mockSubscriptions.length,
                itemBuilder: (context, index) {
                    final subscription = mockSubscriptions[index];

                    return SubscriptionCard(
                        subscription: subscription,
                        onTap: (){
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
        );
    } 
}
