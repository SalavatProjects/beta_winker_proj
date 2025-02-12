import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';

import '../bloc/diary_cubit.dart';
import '../bloc/entities_cubit.dart';
import '../ui_kit/app_colors.dart';
import '../ui_kit/app_styles.dart';
import '../utils/constants.dart';

class ProjectDiariesPage extends StatelessWidget {
  int projectId;

  ProjectDiariesPage({
    super.key,
    required this.projectId,
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
              CustomAppBar(text: 'Observation diary'),
              BlocSelector<EntitiesCubit, EntitiesState, List<DiaryState>>(
                selector: (state) => state.diaries,
                builder: (context, diaries) {
                  final List<DiaryState> projectDiaries = diaries.where((e) => e.projectIds.contains(projectId)).toList();
                  if (projectDiaries.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(
                              projectDiaries.length,
                                  (int index) =>
                                  _DiaryCard(
                                    imagePath: projectDiaries[index].imagePath,
                                    name: projectDiaries[index].subject,
                                    description: projectDiaries[index].description,
                                    hashtags: [projectDiaries[index].mark, projectDiaries[index].category],
                                    date: projectDiaries[index].date!,
                                    onDelete: () {
                                      context.read<EntitiesCubit>().deleteDiary(projectDiaries[index].id!);
                                    },
                                  )
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: 118.w,),
                        Text('There are no entries yet', style: AppStyles.gilroyMediumGrey1(15.sp),),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );;
  }
}

class _DiaryCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String description;
  final List<String> hashtags;
  final DateTime date;
  final void Function() onDelete;

  _DiaryCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.hashtags,
    required this.date,
    required this.onDelete,
  });

  @override
  State<_DiaryCard> createState() => _DiaryCardState();
}

class _DiaryCardState extends State<_DiaryCard> {
  bool _isOnDeleteOpen = false;
  final double _onDeleteBtnWidth = 80.w;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: SizedBox(
        height: 106.w,
        width: MediaQuery.of(context).size.width + _onDeleteBtnWidth,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: AppConstants.duration200,
              right: _isOnDeleteOpen ? _onDeleteBtnWidth : 0,
              child: Container(
                padding: EdgeInsets.all(12.w),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey3,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(
                      File(widget.imagePath),
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 12.w),
                    SizedBox(
                      width: 140.w,
                      height: 80.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: AppStyles.gilroyMediumGreen(24.sp),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.gilroyRegularLightBlack(12.sp),
                          ),
                          Wrap(
                            spacing: 6.w,
                            children: widget.hashtags
                                .map((tag) => Text(
                                tag,
                                style: AppStyles.gilroyMediumGreen(8.sp).copyWith(decoration: TextDecoration.underline)
                            ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd.MM.yyyy').format(widget.date),
                            style: AppStyles.gilroyRegularGrey1(12.sp),
                          ),
                          SizedBox(height: 20.h),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            sizeStyle: CupertinoButtonSize.small,
                            onPressed: () {
                              setState(() {
                                _isOnDeleteOpen = !_isOnDeleteOpen;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'More details',
                                  style: AppStyles.gilroyRegularBlack(12.sp),
                                ),
                                _isOnDeleteOpen ?
                                RotatedBox(
                                  quarterTurns: 2,
                                  child: SvgPicture.asset('assets/icons/Right.svg', colorFilter: ColorFilter.mode(
                                      AppColors.black, BlendMode.srcIn),
                                  ),
                                ) :
                                SvgPicture.asset('assets/icons/Right.svg', colorFilter: ColorFilter.mode(
                                    AppColors.black, BlendMode.srcIn),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: AppConstants.duration200,
              right: _isOnDeleteOpen ? 0 : -_onDeleteBtnWidth,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: widget.onDelete,
                child: Container(
                  width: _onDeleteBtnWidth,
                  height: 106.w,
                  color: AppColors.red,
                  child: Center(
                    child: SizedBox(
                      height: 40.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('assets/icons/Delete.svg'),
                          Text('Delete', style: AppStyles.gilroyMediumWhite(12.sp),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
