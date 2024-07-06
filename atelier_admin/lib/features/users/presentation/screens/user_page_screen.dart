import 'package:atelier_admin/features/users/presentation/widgets/custom_user_widget.dart';
import 'package:flutter/cupertino.dart';

class UserPageScreen extends StatefulWidget {
  const UserPageScreen({super.key});

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 5,
        runSpacing: 10,
        children: List.generate(10, (index) {
          return CustomUserWidget();
        },),
      ),
    );
  }
}
