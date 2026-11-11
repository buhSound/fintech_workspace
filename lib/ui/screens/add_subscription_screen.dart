import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/subscription.dart';
import '../../viewmodels/subscription_viewmodel.dart';

class AddSubscriptionScreen extends StatefulWidget{
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}
class _AddSubscriptionScreenState extends State<AddSubscriptionScreen>{
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _costController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    super.dispose();
  }
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(), // No permite fechas en el pasado
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveSubscription(){
    if(_formKey.currentState!.validate()){
      final String newId = 'sub_${DateTime.now().millisecondsSinceEpoch}';

      final newSub = Subscription(
        id: newId,
        name: _nameController.text.trim(),
        monthlyCost: int.parse(_costController.text.trim()),
        nextBillingDate: _selectedDate,
        logoAssetPath: 'assets/images/card.png',
        sharedWith: [],
      );

      context.read<SubscriptionViewModel>().addSubscription(newSub);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Suscripcion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ej: ChatGPT',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Ingresa un nombre' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Costo mensual (CLP)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingresa un costo';
                  if (int.tryParse(value) == null) return 'Ingresa solo numeros';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Fecha del proximo cobro'),
                subtitle: Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                trailing: const Icon(Icons.calendar_month),
                onTap: () => _pickDate(context),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _saveSubscription,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Guardar Suscripcion', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}