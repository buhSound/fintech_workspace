import 'package:fintech_workspace/ui/screens/master_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'login_screen.dart';
//import 'dashboard_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>{
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().checkExistingSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    if(vm.isCheckingSession){
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if(vm.isAutheticated){
      return const MasterListScreen();
    }

    return const LoginScreen();
  }
}