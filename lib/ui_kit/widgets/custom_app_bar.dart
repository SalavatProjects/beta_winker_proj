import 'package:flutter/cupertino.dart';
import 'package:beta_winker_proj/ui_kit/ui_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  String text;

  CustomAppBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 42.w,
        padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 6.w),
        color: AppColors.green,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 42.w,
              child: GestureDetector(
                  child: SvgPicture.asset('assets/icons/Left.svg'),
                  onTap: () => Navigator.of(context).pop()
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: AppStyles.gilroyMediumWhite(20.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 42.w,
            )
          ],
        ),
      ),
    );
  }
}
