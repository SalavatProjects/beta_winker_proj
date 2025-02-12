import 'package:beta_winker_proj/ui_kit/app_styles.dart';
import 'package:beta_winker_proj/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../ui_kit/app_colors.dart';
import '../ui_kit/widgets/custom_app_bar.dart';

class EcologyTipsPage extends StatelessWidget {
  const EcologyTipsPage({super.key});

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
              CustomAppBar(text: 'Ecology tips'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(AppConstants.ecologyTips.length,
                        (int index) => _TipCard(
                            name: AppConstants.ecologyTips[index].$1,
                            title: AppConstants.ecologyTips[index].$2,
                            color: index % 2 == 0 ? AppColors.white : AppColors.lightGreen,
                        )),
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

class _TipCard extends StatelessWidget {
  final String name;
  final String title;
  final Color color;

  const _TipCard({
    super.key,
    required this.name,
    required this.title,
    this.color = AppColors.white
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/Tick.svg'),
          SizedBox(width: 8.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppStyles.gilroyMediumBlack(15.sp),),
              SizedBox(height: 10.w,),
              SizedBox(
                  width: 240.w,
                  child: Text(title, style: AppStyles.gilroyRegularBlack(14.sp),))
            ],
          )
        ],
      ),
    );
  }
}
