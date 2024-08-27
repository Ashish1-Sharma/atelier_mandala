import 'package:atelier_user/constraints/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        backgroundColor: AppColors.black6,
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black1,
        ),
        title: Text("Settings & activity"),
      ),
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                    children: [
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account"),
                  ListTile(
                    leading: Image.asset(
                      "assets/users/u_three.png",
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                    title: Text("Manage Account"),
                    subtitle: Text("email"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("General"),
                  ListTile(
                    leading: Icon(Icons.favorite_border),
                    title: Text("Saved"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                      size: 15,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text("Notifications"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                      size: 15,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text("App Language"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                      size: 15,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text("Support Center"),
                    subtitle: Text("FAQs, chat with us, help"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                      size: 15,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Saved"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                      size: 15,
                    ),
                  )
                ],
              ),
            )
                    ],
                  ),
          )),
    );
  }
}
