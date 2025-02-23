import 'dart:io';
import 'package:beta_winker_proj/bloc/category_cubit.dart';
import 'package:beta_winker_proj/bloc/diary_cubit.dart';
import 'package:beta_winker_proj/bloc/entities_cubit.dart';
import 'package:beta_winker_proj/bloc/mark_cubit.dart';
import 'package:beta_winker_proj/pages/add_diary_page.dart';
import 'package:beta_winker_proj/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beta_winker_proj/ui_kit/ui_kit.dart';
import 'package:intl/intl.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

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
                  if (diaries.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(
                              diaries.length,
                              (int index) =>
                            _DiaryCard(
                                imagePath: diaries[index].imagePath,
                                name: diaries[index].subject,
                                description: diaries[index].description,
                                hashtags: [diaries[index].mark, diaries[index].category],
                                date: diaries[index].date!,
                                onDelete: () {
                                  context.read<EntitiesCubit>().deleteDiary(diaries[index].id!);
                                },
                              )
                          ),
                          SizedBox(height: 28.w,),
                          YellowBtn(
                              text: 'Create entry ',
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) =>
                                      MultiBlocProvider(
                                        providers: [
                                          BlocProvider(create: (context) => DiaryCubit()),
                                          BlocProvider(create: (context) => MarkCubit()),
                                          BlocProvider(create: (context) => CategoryCubit())
                                        ],
                                        child: AddDiaryPage(),
                                      )
                                  )
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
                        SizedBox(height: 28.w,),
                        YellowBtn(
                            text: 'Create entry ',
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) => 
                                    MultiBlocProvider(
                                  providers: [
                                    BlocProvider(create: (context) => DiaryCubit()),
                                    BlocProvider(create: (context) => MarkCubit()),
                                    BlocProvider(create: (context) => CategoryCubit())
                                  ],
                                  child: AddDiaryPage(),
                                )
                                )
                            )
                        ),
                              
                      ],
                    );
                  }

                },
              )
            ],
          ),
        ),
      ),
    );
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
