import 'package:flutter/material.dart';

import '../../../../constraints/colors.dart';

class ProfileDropDownMenu extends StatefulWidget {
  const ProfileDropDownMenu({super.key});

  @override
  State<ProfileDropDownMenu> createState() => _ProfileDropDownMenuState();
}

class _ProfileDropDownMenuState extends State<ProfileDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      padding: EdgeInsets.only(left: 10),
      icon: Icon(Icons.keyboard_arrow_down,color: AppColors.brandColor,),
      items: ["Edit Profile" ,"Help" , "Logout"].map(
            (e) {
          return DropdownMenuItem(
            child: Text(e),
            value: e,
          );
        },
      ).toList(),
      onChanged: (value) {
      },
    )
    ;
  }
}
