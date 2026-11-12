import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'subscription.g.dart';

@HiveType(typeId: 0)
@immutable
class Subscription{
    @HiveField(0)
    final String id;
    @HiveField(1)
    final String name;
    @HiveField(2)
    final int monthlyCost;
    @HiveField(3)
    final DateTime nextBillingDate;
    @HiveField(4)
    final String logoAssetPath;
    @HiveField(5)
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