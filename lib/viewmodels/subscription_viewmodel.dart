import 'package:flutter/foundation.dart';
import '../domain/models/subscription.dart';
import "../domain/models/mock_data.dart";
import '../domain/models/mock_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final Box<Subscription> _box;

  SubscriptionViewModel({required Box<Subscription> box}) : _box = box{
    if(_box.isEmpty){
      for(var sub in mockSubscriptions){
        _box.put(sub.id, sub);
      }
    }
  }
  //final List<Subscription> _subscriptions = List.from(mockSubscriptions);

  List <Subscription> get subscriptions => _box.values.toList();

  int get totalMonthlyCost{
    return subscriptions.fold<int>(0, (sum, item) => sum + item.monthlyCost);
  }

  void addSubscription(Subscription subscription){
    _box.put(subscription.id, subscription);
    notifyListeners();
  }

  void removeSubscription(String id){
    _box.delete(id);
    notifyListeners();
  }
}