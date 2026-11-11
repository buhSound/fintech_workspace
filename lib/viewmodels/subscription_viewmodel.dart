import 'package:flutter/foundation.dart';
import '../domain/models/subscription.dart';
import "../domain/models/mock_data.dart";

class SubscriptionViewModel extends ChangeNotifier {
  final List<Subscription> _subscriptions = List.from(mockSubscriptions);

  List <Subscription> get subscriptions => _subscriptions;

  int get totalMonthlyCost{
    return _subscriptions.fold<int>(0, (sum, item) => sum + item.monthlyCost);
  }

  void addSubscription(Subscription subscription){
    _subscriptions.add(subscription);
    notifyListeners();
  }

  void removeSubscription(String id){
    _subscriptions.removeWhere((sub) => sub.id == id);
    notifyListeners();
  }
}