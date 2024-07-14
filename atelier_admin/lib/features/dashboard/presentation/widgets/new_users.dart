import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/global_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/space.dart';
import '../../../../global_models/user_model.dart';

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
            const Text('View All',style: TextStyle(color: AppColors.brandColor),)
          ],
        ),
        Space.spacer(0.01),
        StreamBuilder(
          stream: GlobalFirebase.cloud.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');
              default:
                return Card(
                  color: AppColors.black6,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (snapshot.data?.docs[index] == null) return Container(); // Handle potential null doc

                      final doc = snapshot.data!.docs[index];
                      final user = UserModel(
                        name: doc.data()['name'] as String,
                        email: doc.data()['email'] as String,
                        image: false, // Assuming a default value for now
                        time: DateTime.now(),
                      );
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.brandColor,
                          child: Text(
                            user.name.toString().substring(0, 1).toUpperCase(),
                            style: AppTextStyles.bodyBig(color: AppColors.black6),
                          ),
                        ),
                        title: Text(
                          user.name.toString().substring(0, 1).toUpperCase() +
                              user.name.toString().substring(1).toLowerCase(),
                          style: AppTextStyles.bodyMain16(color: AppColors.black1),
                        ),
                        subtitle: Text(
                          user.email,
                          style: AppTextStyles.bodySmallest(color: AppColors.black3),
                        ),
                      );
                    },
                  ),
                );
            }
          },
        )

      ],
    );
  }
}
