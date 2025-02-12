import 'dart:io';
import 'dart:math';

import 'package:beta_winker_proj/bloc/diary_cubit.dart';
import 'package:beta_winker_proj/bloc/location_cubit.dart';
import 'package:beta_winker_proj/pages/community_diary_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/entities_cubit.dart';
import '../ui_kit/app_colors.dart';
import '../ui_kit/app_styles.dart';
import 'filter_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final TextEditingController _searchEditingController = TextEditingController();
  List<DiaryState> _searchedDiaries = [];
  Random _random = Random();

  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
  }

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
              CustomAppBar(text: 'Community'),
              SizedBox(height: 7.w,),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 38.w,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 38.w,
                                  padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.lightGrey4
                                  ),
                                  child: TextFormField(
                                    controller: _searchEditingController,
                                    style: AppStyles.gilroyMediumGreen(15.sp),
                                    onChanged: (value) {

                                    },
                                    decoration: InputDecoration(
                                        icon: SvgPicture.asset('assets/icons/Search.svg'),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              CupertinoButton(
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) =>
                                        FilterPage()
                                    )
                                ),
                                padding: EdgeInsets.zero,
                                sizeStyle: CupertinoButtonSize.small,
                                child: SizedBox(
                                  width: 24.w,
                                  height: 24.w,
                                  child: SvgPicture.asset('assets/icons/Filter.svg', fit: BoxFit.fill,),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.w,),
                        BlocSelector<EntitiesCubit, EntitiesState, List<DiaryState>>(
                          selector: (state) => state.diaries,
                          builder: (context, diaries) {
                            if(_searchEditingController.text.isEmpty) {
                              _searchedDiaries = diaries;
                            }
                            if (_searchedDiaries.isNotEmpty) {
                              return SingleChildScrollView(
                                child: Wrap(
                                  spacing: 16.w,
                                  runSpacing: 16.w,
                                  children: [
                                    ...List.generate(
                                        _searchedDiaries.length,
                                            (int index) {
                                              int likesCount = _random.nextInt(1001);
                                              int viewsCount = _random.nextInt(1001);
                                              int commentsCount = _random.nextInt(10);
                                              LocationState location = context.read<EntitiesCubit>().state.locations[
                                                _random.nextInt(context.read<EntitiesCubit>().state.locations.length)];
                                              return _DiaryCardBtn(
                                                  diary: _searchedDiaries[index],
                                                  likesCount: likesCount,
                                                  viewsCount: viewsCount,
                                                  commentsCount: commentsCount,
                                                  onPressed: () => Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (BuildContext context) =>
                                                          CommunityDiaryPage(
                                                              diary: _searchedDiaries[index],
                                                              location: location,
                                                              likesCount: likesCount,
                                                              viewsCount: viewsCount,
                                                              commentsCount: commentsCount)
                                                      )
                                                  )
                                              );
                                            }
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  SizedBox(height: 118.w,),
                                  Text('There are no diaries yet', style: AppStyles.gilroyMediumGrey1(15.sp),),
                                ],
                              );
                            }

                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiaryCardBtn extends StatelessWidget {
  final DiaryState diary;
  final int likesCount;
  final int viewsCount;
  final int commentsCount;
  final void Function() onPressed;

  const _DiaryCardBtn({
    super.key,
    required this.diary,
    required this.likesCount,
    required this.viewsCount,
    required this.commentsCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: SizedBox(
        width: 138.w,
        height: 174.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 116.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.r),
                image: DecorationImage(image: FileImage(File(diary.imagePath)),fit: BoxFit.fitWidth)
              ),
            ),
            SizedBox(height: 4.w,),
            Text(diary.subject, style: AppStyles.gilroySemiBoldGreen(13.sp),),
            SizedBox(height: 4.w,),
            Row(
              children: [
                SizedBox(
                    width: 10.w,
                    height: 10.w,
                    child: SvgPicture.asset('assets/icons/Heart.svg')),
                SizedBox(width: 2.w,),
                Text(likesCount.toString(), style: AppStyles.gilroyRegularGrey1(10.sp),),
                SizedBox(width: 5.w,),
                SizedBox(
                    width: 10.w,
                    height: 10.w,
                    child: SvgPicture.asset('assets/icons/Profile.svg')),
                SizedBox(width: 2.w,),
                Text(viewsCount.toString(), style: AppStyles.gilroyRegularGrey1(10.sp),),
              ],
            ),
            SizedBox(height: 4.w,),
            Text('Comment: $commentsCount', style: AppStyles.gilroyRegularGrey1(11.sp),)
          ],
        ),
      ),
    );
  }
}
