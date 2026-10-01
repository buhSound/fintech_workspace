import 'package:flutter/material.dart';
import 'ui/theme/app_theme.dart';
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

      theme: AppTheme.lightTheme,
    );
  }
}