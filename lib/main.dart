import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

void main(){
  runApp(const BiometricPoCApp());
}

class BiometricPoCApp extends StatelessWidget{
  const BiometricPoCApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SensorValidationScreen(),
    );
  }
}

class SensorValidationScreen extends StatefulWidget{
  const SensorValidationScreen({super.key});

  @override
  State<SensorValidationScreen> createState() => _SensorValidationScreenState();
}

class _SensorValidationScreenState extends State<SensorValidationScreen>{
  final LocalAuthentication auth = LocalAuthentication();
  String _logStatus = 'Prueba de mensaje 1 2 3 Ponga el dedo';

  Future<void> _triggerSensor() async{
    setState((){
      _logStatus = 'Verificando el funcionamiento ';
    });

    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics ||
          await auth.isDeviceSupported();

      if (!canAuthenticate) {
        setState(() => _logStatus = 'Error no huella digital');
        return;
      }

      setState(() => _logStatus = 'Buscando el sensor');

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Autenticate',
        biometricOnly: true,
        //stickyAuth: true,
        //useErrorDialogs: true,
      );


      setState(() {
        _logStatus = didAuthenticate
            ? 'Huella validada correctamente'
            : 'Huella incorrecta. Reintente';
      });
      /*
      /Mensajes que entrega Android al error en ejecucion,
      comparalos y entregar un mensaje mas claro.

      Manejo de Excepciones
      */
    } on PlatformException catch (e) {
      setState(() {
        if (e.code == 'NotEnrolled') {
          _logStatus = 'No tiene huellas registradas en su telefono';
        } else if (e.code == 'NotAvailable') {
          _logStatus = 'Hardware desactivado';
        } else {
          _logStatus = 'Error critico';
        }
      });
    } catch (e) {
      setState(() => _logStatus = 'Error desconocido: $e');
    }
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text ('PoC: Sensor Biometrico')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: Text(
                _logStatus,
                style: const TextStyle(color: Colors.green, fontFamily:'monoSpace', fontSize: 14 ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _triggerSensor,
              icon: const Icon(Icons.fingerprint, size: 32),
              label: const Text('Leer Huella'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
          ],
        ),
      ),
    );
  }
}