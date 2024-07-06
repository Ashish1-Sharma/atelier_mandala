import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/space.dart';

class NewUsers extends StatefulWidget {
  const NewUsers({super.key});

  @override
  State<NewUsers> createState() => _NewUsersState();
}

class _NewUsersState extends State<NewUsers> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Space.spacer(0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('New User',style: AppTextStyles.h4(color: Colors.black),),
            Text('View All',style: TextStyle(color: AppColors.brandColor),),
          ],
        ),
        Space.spacer(0.01),
        Card(
          color: AppColors.black6,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset("assets/images/users/user${index+1}.png"),
              title: Text("Ashish sharma",style: AppTextStyles.bodyMain16(color: AppColors.black1),),
              subtitle: Text("wwwviveksharma45@gmail.com",style: AppTextStyles.bodySmallest(color: AppColors.black3)),
            );
          },),
        )
      ],
    );
  }
}
