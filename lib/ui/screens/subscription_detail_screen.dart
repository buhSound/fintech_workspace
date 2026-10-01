import 'package:flutter/material.dart';

import '../../domain/models/subscription.dart';

class SubscriptionDetailScreen extends StatelessWidget{
  final Subscription subscription;

  const SubscriptionDetailScreen({
    super.key,
    required this.subscription,
  });

  String _formatCLP(num amount) {
    final str = amount.round().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return '\$ $str';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = Theme.of(context);
    final bool isShared = subscription.sharedWith.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(subscription.name),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //1. Primer visual
            Center(
              child: Column(
                children: [
                  Hero(
                    tag: subscription.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        subscription.logoAssetPath,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 120,
                          height: 120,
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.broken_image, size: 48),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _formatCLP(subscription.monthlyCost),
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Proximo cobro: ${subscription.nextBillingDate.day}/${subscription.nextBillingDate.month}/${subscription.nextBillingDate.year}',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            //2. Logica de dominio
            Text(
              'Desglose Financiero',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow(context, 'Costo Total', _formatCLP(subscription.monthlyCost)),
                    const Divider(height: 24),
                    _buildDetailRow(
                      context,
                      'Tu cuota ${isShared ? "(Dividido)" : "(Individual)"}',
                      _formatCLP(subscription.costPerPerson),
                      isHighlight: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            if(isShared) ...[
              Text(
                'Compartido con (${subscription.sharedWith.length})',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...subscription.sharedWith.map((user) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text( 
                    user.substring(0, 1).toUpperCase(),
                    style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
                  ),
                ),
                title: Text(user, style: const TextStyle(fontWeight: FontWeight.w500)),
                trailing: Text(_formatCLP(subscription.costPerPerson)),
              )),
            ] else ...[
              Center(
                child: Text(
                  'Suscripcion de uso personal',
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontStyle: FontStyle.italic),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
  Widget _buildDetailRow(BuildContext context, String label, String value, {bool isHighlight = false}) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isHighlight ? theme.colorScheme.primary : theme.colorScheme.onSurface,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isHighlight ? theme.colorScheme.primary : theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}