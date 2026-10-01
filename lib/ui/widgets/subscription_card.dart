import 'package:flutter/material.dart';
import '../../domain/models/subscription.dart';

class SubscriptionCard extends StatelessWidget{
    final Subscription subscription;
    final VoidCallback onTap;

    const SubscriptionCard({
        super.key,
        required this.subscription,
        required this.onTap,
    });

    String _formatCLP(int amount){
        final str = amount.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]}.',
        );
        return '\$ $str';
    }

    @override
    Widget build(BuildContext context){
        final theme = Theme.of(context);

        return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
                onTap: onTap,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                    subscription.logoAssetPath,
                                    width: 56,
                                    height: 56,
                                    fit: BoxFit.cover,

                                    errorBuilder: (context, error, stackTrace) => Container(
                                        width: 56, 
                                        height: 56,
                                        color: theme.colorScheme.surfaceContainerHighest,
                                        child: const Icon(Icons.image_not_supported),
                                    ),
                                ),
                            ),
                            const SizedBox(width: 16),

                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            subscription.name,
                                            style: theme.textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            'Proximo cobro en ${subscription.daysUntilBilling} dias',
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                                color: theme.colorScheme.onSurfaceVariant,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                    Text(
                                        _formatCLP(subscription.monthlyCost),
                                        style: theme.textTheme.titleMedium?.copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                        ),
                                    ),
                                    const SizedBox(height: 4),
                                    Icon(
                                        Icons.chevron_right,
                                        color: theme.colorScheme.onSurfaceVariant,
                                        size: 20,
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}