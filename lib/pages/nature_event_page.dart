import 'package:beta_winker_proj/ui_kit/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class NatureEventPage extends StatelessWidget {
  final String imagePath;
  final String head;
  final String text;
  final String date;

  const NatureEventPage({
    super.key,
    required this.imagePath,
    required this.head,
    required this.text,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.w),
          child: Column(
            children: [
              SizedBox(
                width: 130.w,
                height: 24.w,
                child: SvgPicture.asset('assets/icons/BetaWinker.svg'),
              ),
              SizedBox(height: 7.w,),
              CustomAppBar(text: 'Events in the natural world'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200.w,
                        child: Image.asset(imagePath, fit: BoxFit.fitHeight,),
                      ),
                      SizedBox(height: 12.w,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(head, style: AppStyles.gilroySemiBoldBlack(15.sp),),
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    Share.share('$head \n\n $text');
                                  },
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.w,
                                    child: SvgPicture.asset('assets/icons/solar_share-linear.svg'),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 4.w,),
                            Text(date, style: AppStyles.gilroyRegularGrey3(9.sp),),
                            SizedBox(height: 8.w,),
                            Text(text, style: AppStyles.gilroyRegularBlack(12.sp),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
