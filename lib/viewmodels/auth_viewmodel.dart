import 'package:flutter/foundation.dart';
import '../services/biometric_auth_service.dart';

class AuthViewModel extends ChangeNotifier{
  final BiometricAuthService _biometricService;

  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;

  AuthViewModel({required BiometricAuthService biometricService})
    : _biometricService = biometricService;

  bool get isLoading =>isLoading;
  bool get isAutheticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  Future<void> loginWithBiometrics() async{
    _setLoading(true);

    final isAvailable = await _biometricService.isBiometricAvailable();
    if(!isAvailable){
      _setError('Hardware biometrico no configurado o no disponible.');
      return;
    }

    final success = await _biometricService.authenticate();

    if (success) {
      _isAuthenticated = true;
      _errorMessage = null;
      notifyListeners();
    } else {
      _setError('Huella no reconocida o autenticacion cancelada');
    }
    _setLoading(false);
  }

  void _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message){
    _errorMessage = message;
    _isLoading = false;
    notifyListeners();
  }
}