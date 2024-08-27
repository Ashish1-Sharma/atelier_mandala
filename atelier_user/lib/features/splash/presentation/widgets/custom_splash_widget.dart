import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_widgets/custom_elevated_button.dart';

class CustomSplashWidget extends StatefulWidget {
  final PageController? pageController;
  final String txt;
  final int idx;
  const CustomSplashWidget({super.key, required this.txt, required this.idx,this.pageController});

  @override
  State<CustomSplashWidget> createState() => _CustomSplashWidgetState();
}

class _CustomSplashWidgetState extends State<CustomSplashWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/splash/splash_${widget.idx + 1}.png",width: double.infinity,),
        Space.spacer(0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widget.idx == 0 ? 50 : 30,
              height: 10,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color:  widget.idx == 0 ? AppColors.brandColor : AppColors.black4,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            Container(
              width: widget.idx == 1 ? 50 : 30,
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 10,
              decoration: BoxDecoration(
                  color:  widget.idx == 1 ? AppColors.brandColor : AppColors.black4,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            Container(
              width: widget.idx == 2 ? 50 : 30,
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 10,
              decoration: BoxDecoration(
                  color: widget.idx == 2 ? AppColors.brandColor : AppColors.black4,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
        Text(widget.txt,style: AppTextStyles.h4(color: AppColors.black2),),
        // Space.spacer(0.02),
        Container(
            width: double.infinity,
            // alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(20),
            child: CustomElevatedButton(backColor: AppColors.tertiaryColor, txtColor: AppColors.black6, txt: widget.idx == 2 ? "Get Started" : "Next", onPressed: (){
              print(widget.idx);
              if(widget.idx==2){
                Get.offAndToNamed('/login');
              } else{
                widget.pageController?.animateToPage(widget.idx+1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
              }

            }))
      ],
    );
  }
}
