import 'package:atelier_admin/features/authentication/presentation/screens/login_screen.dart';
import 'package:atelier_admin/root_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Atelier mandala',
      home: LoginScreen(),
    );
  }
}

