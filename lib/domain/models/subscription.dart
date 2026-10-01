import 'package:flutter/foundation.dart';

@immutable
class Subscription{
    final String id;
    final String name;
    final int monthlyCost;
    final DateTime nextBillingDate;
    final String logoAssetPath;
    final List<String> sharedWith;

    const Subscription({
        required this.id,
        required this.name,
        required this.monthlyCost,
        required this.nextBillingDate,
        required this.logoAssetPath,
        required this.sharedWith,
    });

    double get costPerPerson{
        if(sharedWith.isEmpty) return monthlyCost.toDouble();
        //division del costo total entre los miembros compartidos 
        return monthlyCost / (sharedWith.length + 1);
    }

    int get daysUntilBilling{
        final now = DateTime.now();
        final difference = nextBillingDate.difference(now);
        return difference.inDays > 0 ? difference.inDays : 0;
    }
}