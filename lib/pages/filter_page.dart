import 'dart:io';

import 'package:beta_winker_proj/bloc/diary_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../bloc/entities_cubit.dart';
import '../ui_kit/app_colors.dart';
import '../ui_kit/app_styles.dart';
import '../utils/constants.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController _searchEditingController = TextEditingController();
  DateTime? _date;
  List<DiaryState> _diaries = [];

  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
  }

  void _search() {
    setState(() {
      if (_searchEditingController.text.isNotEmpty && _date == null) {
          _diaries = context.read<EntitiesCubit>().state.diaries.where((e) => e.subject.toLowerCase().startsWith(_searchEditingController.text.toLowerCase())).toList();
        } else if(_searchEditingController.text.isEmpty && _date != null) {
        _diaries = context.read<EntitiesCubit>().state.diaries.where((e) => e.date == _date!).toList();
      } else if (_searchEditingController.text.isNotEmpty && _date !=null) {
        _diaries = context.read<EntitiesCubit>().state.diaries.where((e) => (e.subject.toLowerCase().startsWith(_searchEditingController.text.toLowerCase()) && e.date == _date)).toList();
      }
    });
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
              CustomAppBar(text: 'Observation map'),
              SizedBox(height: 7.w,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 38.w,
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
                                  decoration: InputDecoration(
                                      icon: SvgPicture.asset('assets/icons/Search.svg'),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 7.w,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() async {
                                    _date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2015),
                                        lastDate: DateTime(2074));
                                  });

                                },
                                child: Container(
                                  width: 107.w,
                                  height: 32.w,
                                  padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 9.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: AppColors.lightGrey1,),
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: AppColors.lightPink
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          width: 16.w,
                                          height: 16.w,
                                          child: SvgPicture.asset('assets/icons/Calender.svg')),
                                      Text(_date != null ? DateFormat('dd.MM.yyyy').format(_date!) : '00.00.0000', style: AppStyles.gilroyRegularLightGrey2(13.sp),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      if (_diaries.isNotEmpty)
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 7.w,),
                                  ...List.generate(
                                      _diaries.length, (int index) =>
                                      _DiaryCard(
                          imagePath: _diaries[index].imagePath,
                          name: _diaries[index].subject,
                          description: _diaries[index].description,
                          hashtags: [_diaries[index].mark, _diaries[index].category],
                          date: _diaries[index].date!,
                          onDelete: () {
                            context.read<EntitiesCubit>().deleteDiary(_diaries[index].id!);
                          })
                                    ),
                                  SizedBox(height: 28.w,),
                                  YellowBtn(
                                      text: 'Search',
                                      onPressed: () => _search(),
                                  ),
                                ],
                              ),
                            )
                          else
                            Column(
                              children: [
                                SizedBox(height: 118.w,),
                                YellowBtn(
                                    text: 'Search',
                                    onPressed: () => _search(),
                                ),
                              ],
                            )
                    ],
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
