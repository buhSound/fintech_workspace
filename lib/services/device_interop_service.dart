import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceInteropService {
  //Menu nativo para compartir archivos en el telefono
  Future<void> shareContent(String text, {String? subject}) async{
    await Share.share(text, subject: subject);
  }

  Future<void> openWebLink(String urlString) async{
    final Uri url = Uri.parse(urlString);

    if(await canLaunchUrl(url)){
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('No se pudo abrin el enlace: $urlString');
    }
  }

  Future<void> sendSupportEmail() async{
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'diegocontreras1257@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Ayuda con mi cuenta Fintech Workspace',
    }),
    );
    if(await canLaunchUrl(emailLaunchUri)){
      await launchUrl(emailLaunchUri);
    }
  }

  String? _encodeQueryParameters(Map<String, String> params){
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }
}