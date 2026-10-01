import 'subscription.dart';

final List<Subscription> mockSubscriptions = [
  Subscription(
    id: 'sub_001',
    name: 'Netflix Premium',
    monthlyCost: 11790,
    nextBillingDate: DateTime.now().add(const Duration(days:12)),
    logoAssetPath: 'assets/images/netflix.png',
    sharedWith: ['Papá', 'Mamá'],
  ),
  Subscription(
    id: 'sub_002',
    name: 'Spotify Familiar',
    monthlyCost: 6290,
    nextBillingDate: DateTime.now().add(const Duration(days:3)),
    logoAssetPath: 'assets/images/spotify.png',
    sharedWith: ['Compañero 1', 'Compañero 2', 'Compañero 3'],
  ),
  Subscription(
    id: 'sub_003',
    name: 'AWS Cloud (EC2)',
    monthlyCost: 8500,
    nextBillingDate: DateTime.now().add(const Duration(days: 20)),
    logoAssetPath: 'assets/images/aws.png',
    sharedWith: [],
  ),
  Subscription(
    id: 'sub_004',
    name: 'Gimnasio Smartfit Talca',
    monthlyCost: 16900,
    nextBillingDate: DateTime.now().add(const Duration(days: 7)),
    logoAssetPath: 'assets/images/gym.png',
    sharedWith: [],
  ),
];