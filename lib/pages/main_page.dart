import 'package:beta_winker_proj/ui_kit/app_colors.dart';
import 'package:beta_winker_proj/ui_kit/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 130.w,
                    height: 24.w,
                    child: SvgPicture.asset('assets/icons/BetaWinker.svg'),
                  ),
                ),
                SizedBox(height: 30.w,),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.w,
                  children: [
                    _CardBtn(
                        iconPath: 'assets/icons/arcticons_diary.svg',
                        text: 'Observation diary',
                        onPressed: () {},
                    ),
                    _CardBtn(
                      iconPath: 'assets/icons/Connector.svg',
                      text: 'Projects',
                      onPressed: () {},
                    ),
                    _CardBtn(
                      iconPath: 'assets/icons/Solar Panel.svg',
                      text: 'Observation map',
                      onPressed: () {},
                    ),
                    _CardBtn(
                      iconPath: 'assets/icons/World.svg',
                      text: 'Сommunity',
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 22.w,),
                Text('Information of the day', style: AppStyles.gilroyMediumGreen(18.sp),
                ),
                _UnderBtn(text: 'Ecology tips',
                    onPressed: () {}),
                _UnderBtn(text: 'Events in the natural world',
                    onPressed: () {}),
              ],
            ),
          )
      ),
    );
  }
}

class _CardBtn extends StatelessWidget {
  String iconPath;
  String text;
  void Function() onPressed;

  _CardBtn({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          width: (MediaQuery.of(context).size.width / 2) - 30.w,
          height: 200.w,
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.lightGreen
          ),
          child: Column(
            children: [
              SvgPicture.asset(iconPath),
              SizedBox(height: 14.w,),
              Text(text,
                  style: AppStyles.gilroySemiBoldGreen(22.sp),
                  textAlign: TextAlign.center,
              )
            ],
          ),
        ),
    );
  }
}

class _UnderBtn extends StatelessWidget {
  String text;
  void Function() onPressed;

  _UnderBtn({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 53.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
              color: AppColors.lightGreen,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/Sprout.svg'),
                    SizedBox(width: 5.w,),
                    Text(text, style: AppStyles.gilroySemiBoldGreen(20.sp),)
                  ],
                ),
                SvgPicture.asset('assets/icons/Right.svg')
              ],
            ),
          )),
    );
  }
}
