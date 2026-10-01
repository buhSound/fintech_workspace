import 'package:flutter/material.dart';
import 'ui/screens/master_list_screen.dart';

void main(){
  runApp(const FintechWorkspaceApp());
}

class FintechWorkspaceApp extends StatelessWidget{
  const FintechWorkspaceApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Fintech Workspace',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), //Azul oscuro
          surface: Colors.grey[50],
        ),
        useMaterial3: true,
      ),
        home: const MasterListScreen()
    );
  }
}