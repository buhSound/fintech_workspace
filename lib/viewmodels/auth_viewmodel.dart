import 'package:fintech_workspace/services/secure_storage_service.dart';
import 'package:flutter/foundation.dart';
import '../services/biometric_auth_service.dart';

class AuthViewModel extends ChangeNotifier{
  final BiometricAuthService _biometricService;
  final SecureStorageService _secureStorage;

  bool _isLoading = false;
  bool _isAuthenticated = false;
  bool _isCheckingSession = true;
  String? _errorMessage;

  AuthViewModel({
    required BiometricAuthService biometricService,
    required SecureStorageService secureStorage,
  }) : _biometricService = biometricService,
      _secureStorage = secureStorage;

  bool get isLoading => _isLoading;
  bool get isAutheticated => _isAuthenticated;
  bool get isCheckingSession => _isCheckingSession;
  String? get errorMessage => _errorMessage;

  Future<void> checkExistingSession() async{
    final token = await _secureStorage.getSessionToken();
    if(token != null){
      _isAuthenticated = true;
    }
    _isCheckingSession = false;
    notifyListeners();
  }

  Future<void> loginWithBiometrics() async{
    _setLoading(true);

    final isAvailable = await _biometricService.isBiometricAvailable();
    if(!isAvailable){
      _setError('Hardware biometrico no configurado o no disponible.');
      return;
    }

    final success = await _biometricService.authenticate();

    if (success) {

      await _secureStorage.saveSessionToken('fintech_token_secreto_xyz123');

      _isAuthenticated = true;
      _errorMessage = null;
      notifyListeners();

    } else {
      _setError('Huella no reconocida o autenticacion cancelada');
    }
    _setLoading(false);
  }

  Future<void> logout() async{
    await _secureStorage.deleteSession();
    _isAuthenticated = false;
    notifyListeners();
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