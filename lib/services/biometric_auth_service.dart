import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async{
    try{
      final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();

      return canAuthenticateWithBiometrics || isSupported;
    } on PlatformException catch(_) {
      return false;
    }
  }

  Future<bool> authenticate() async{
    try {
      return await _auth.authenticate(
          localizedReason: 'Verifica tu huella digital para acceder a tu cuenta',
          biometricOnly: true,
          persistAcrossBackgrounding: true,
      );
    } on PlatformException catch (_) {
      return false;
    } catch (_){
      return false;
    }
  }
}