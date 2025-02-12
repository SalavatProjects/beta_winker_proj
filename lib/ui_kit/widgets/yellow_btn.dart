import 'package:flutter/cupertino.dart';
import 'package:beta_winker_proj/ui_kit/ui_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YellowBtn extends StatelessWidget {
  String text;
  void Function() onPressed;
  bool isActive;

  YellowBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: isActive ? onPressed : null,
        child: Opacity(
          opacity: isActive ? 1 : 0.5,
          child: Container(
            width: 243.w,
            height: 54.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
              color: AppColors.yellow,
            ),
            child: Center(child: Text(text, style: AppStyles.gilroyMediumBlack(20.sp),)),
          ),
        ));
  }
}
