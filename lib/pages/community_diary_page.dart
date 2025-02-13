import 'dart:io';
import 'dart:math';

import 'package:beta_winker_proj/bloc/diary_cubit.dart';
import 'package:beta_winker_proj/bloc/location_cubit.dart';
import 'package:beta_winker_proj/ui_kit/app_styles.dart';
import 'package:beta_winker_proj/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui_kit/app_colors.dart';

class CommunityDiaryPage extends StatelessWidget {
  final DiaryState diary;
  final LocationState? location;
  int likesCount;
  int viewsCount;
  int commentsCount;

  CommunityDiaryPage({
    super.key,
    required this.diary,
    required this.location,
    required this.likesCount,
    required this.viewsCount,
    required this.commentsCount,
  });

  List<DateTime> _randomDates = [];

  void _generateRandomDates() {
    Random random = Random();

    DateTime now = DateTime.now();

    DateTime twoMonthsAgo = now.subtract(Duration(days: 60)); // Принимаем, что месяц — это 30 дней

    List<DateTime> randomDates = [];

    for (int i = 0; i < 10; i++) {
      int randomDays = random.nextInt(now.difference(twoMonthsAgo).inDays);

      DateTime randomDate = twoMonthsAgo.add(Duration(days: randomDays));

      randomDates.add(randomDate);
    }

    randomDates.sort((a, b) => b.compareTo(a)); // b.compareTo(a) для убывания

    _randomDates = List.from(randomDates);
  }

  @override
  Widget build(BuildContext context) {
    _generateRandomDates();
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
              CustomAppBar(text: 'Community'),
              SizedBox(height: 16.w,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        image: DecorationImage(image: FileImage(File(diary.imagePath)), fit: BoxFit.fitWidth,)
                      ),
                    ),
                    SizedBox(height: 7.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(diary.subject, style: AppStyles.gilroySemiBoldGreen(23.sp), overflow: TextOverflow.ellipsis,),
                        SizedBox(
                          width: 130.w,
                          height: 20.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: SvgPicture.asset('assets/icons/Heart.svg', fit: BoxFit.fitWidth,)),
                              SizedBox(width: 2.w,),
                              Text(likesCount.toString(), style: AppStyles.gilroyRegularGrey1(17.sp),),
                              SizedBox(width: 9.w,),
                              SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: SvgPicture.asset('assets/icons/Profile.svg', fit: BoxFit.fitWidth,)),
                              SizedBox(width: 2.w,),
                              Text(viewsCount.toString(), style: AppStyles.gilroyRegularGrey1(17.sp),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7.w,),
                    Row(
                      children: [
                        Text(diary.mark,
                          style: AppStyles.gilroyMediumGreen(12.sp).copyWith(decoration: TextDecoration.underline),),
                        SizedBox(width: 6.w,),
                        Text(diary.category,
                          style: AppStyles.gilroyMediumGreen(12.sp).copyWith(decoration: TextDecoration.underline),),
                      ]
                    ),
                    SizedBox(height: 14.w,),
                    Text('Location', style: AppStyles.gilroyRegularLightBlack(12.sp),),
                    SizedBox(height: 4.w,),
                    if (location != null)
                    _LocationCard(name: location!.name),
                    SizedBox(height: 14.w,),
                    Text(diary.description, style: AppStyles.gilroyRegularGrey2(12.sp), maxLines: 3, overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 14.w,),
                    Text('Comments', style: AppStyles.gilroyRegularLightBlack(15.sp),),
                    SizedBox(height: 10.w,),
                    SizedBox(
                      height: 110.w,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              commentsCount,
                                  (int index) => _CommentCard(
                                      authorName: AppConstants.comments[index].$1,
                                      text: AppConstants.comments[index].$2,
                                      date: _randomDates[index])),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String name;

  const _LocationCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w),
      child: CupertinoButton(
          onPressed: () async {
            if (!await launchUrl(Uri.parse('https://www.google.com/maps'))) {
              throw Exception('Could not launch url');
            }
          },
          padding: EdgeInsets.zero,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 42.w,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: AppColors.lightGreen
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/Location.svg'),
                    SizedBox(width: 4.w,),
                    Text(name, style: AppStyles.gilroyMediumGreen(15.sp), overflow: TextOverflow.ellipsis,)
                  ],
                ),
                SvgPicture.asset('assets/icons/Right.svg'),
              ],
            ),
          )
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  final String authorName;
  final String text;
  final DateTime date;
  
  const _CommentCard({
    super.key,
    required this.authorName,
    required this.text,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.w,),
              Container(
                width: 37.w,
                height: 37.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightBrown,
                ),
                child: Center(child: Text(authorName[0].toUpperCase(), style: AppStyles.robotoRegularWhite(24.sp),)),
              ),
              SizedBox(width: 14.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(authorName, style: AppStyles.gilroyMediumBlack(16.sp).copyWith(color: AppColors.brown)),
                  SizedBox(
                    width: 140.w,
                    child: Text(
                      text,
                      style: AppStyles.gilroyRegularBlack(12.sp).copyWith(color: AppColors.brown),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          ),
          Text(DateFormat('MMMM d').format(date), style: AppStyles.gilroyMediumBlack(12.sp),)
        ],
      ),
    );
  }
}
