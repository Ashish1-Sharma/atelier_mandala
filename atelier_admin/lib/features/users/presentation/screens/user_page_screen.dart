import 'package:atelier_admin/features/users/presentation/widgets/custom_user_widget.dart';
import 'package:atelier_admin/global_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../global_models/user_model.dart';

class UserPageScreen extends StatefulWidget {
  const UserPageScreen({super.key});

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GlobalFirebase.cloud.collection("Users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show progress indicator while waiting for data
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle errors (optional)
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length, // Use data.length directly
            reverse: true,
            itemBuilder: (context, index) {
              final doc = data[index];
              final user = UserModel(
                name: doc.data()['name'] as String,
                email: doc.data()['email'] as String,
                image: false, // Assuming a default value for now
                time: DateTime.now(),
              );
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: CustomUserWidget(
                  image: user.image,
                  name: user.name,
                  email: user.email,
                  time: user.time,
                ),
              );
            },
          );
        }
      },
    );

  }
}
