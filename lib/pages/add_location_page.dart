import 'package:beta_winker_proj/bloc/location_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';

import '../bloc/category_cubit.dart';
import '../bloc/entities_cubit.dart';
import '../bloc/mark_cubit.dart';
import '../ui_kit/app_colors.dart';
import '../ui_kit/app_styles.dart';
import '../utils/constants.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _markEditingController = TextEditingController();
  final TextEditingController _categoryEditingController = TextEditingController();

  bool _isMarkPressed = false;
  bool _isCategoryPressed = false;
  bool _isSaveBtnActive = false;

  void _checkIsSaveBtnActive() {
    setState(() {
      if (
      context.read<LocationCubit>().state.name.isNotEmpty
      ) {
        _isSaveBtnActive = true;
      } else {
        _isSaveBtnActive = false;
      }
    });
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _markEditingController.dispose();
    _categoryEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                  SizedBox(height: 20.w,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 32.w,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 9.w),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: AppColors.lightGrey1,),
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColors.lightPink
                          ),
                          child: Center(
                            child: TextFormField(
                              maxLength: 40,
                              controller: _nameEditingController,
                              style: AppStyles.gilroyRegularBlack(12.sp),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  hintText: 'Location',
                                  hintStyle: AppStyles.gilroyRegularLightGrey2(12.sp)
                              ),
                              onChanged: (value) {
                                context.read<LocationCubit>().updateName(value);
                                _checkIsSaveBtnActive();
                              },
                              buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 9.w,),
                        AnimatedSize(
                          duration: AppConstants.duration200,
                          curve: Curves.easeInOut,
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 9.w),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: AppColors.lightGrey1,),
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.lightPink
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(height: 2.w,),
                                  BlocBuilder<MarkCubit, MarkState>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        controller: _markEditingController,
                                        maxLength: 30,
                                        style: AppStyles.gilroyRegularBlack(12.sp),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true,
                                            hintText: 'Mark',
                                            hintStyle: AppStyles.gilroyRegularLightGrey2(12.sp),
                                            suffixIconConstraints: BoxConstraints(
                                              maxWidth: 14.w,
                                              maxHeight: 14.w,
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isMarkPressed = !_isMarkPressed;
                                                });
                                              },
                                              behavior: HitTestBehavior.opaque,
                                              child: SizedBox(
                                                width: 14.w,
                                                height: 14.w,
                                                child: _isMarkPressed ?
                                                SvgPicture.asset('assets/icons/up.svg') :
                                                SvgPicture.asset('assets/icons/down.svg'),
                                              ),
                                            )
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            final String resultValue = value.startsWith('#') ? value : '#$value';
                                            context.read<LocationCubit>().updateMark(resultValue);
                                            context.read<MarkCubit>().updateName(resultValue);
                                            _markEditingController.text = resultValue;
                                          }

                                        },
                                        onFieldSubmitted: (value) async {
                                          if (value.isNotEmpty) {
                                            if (context.read<EntitiesCubit>().state.marks.firstWhereOrNull((e) => e.name == value) == null) {
                                              await context.read<EntitiesCubit>().addMark(state);
                                            }

                                            if (context.mounted) {
                                              setState(() {
                                                _isMarkPressed = true;
                                              });
                                            }
                                          }
                                        },
                                        buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  if (_isMarkPressed)
                                    Column(
                                      children: [
                                        SizedBox(height: 6.w,),
                                        Divider(
                                          height: 1,
                                          color: AppColors.lightGrey1,
                                        ),
                                        BlocSelector<EntitiesCubit, EntitiesState, List<MarkState>>(
                                          selector: (state) => state.marks,
                                          builder: (context, marks) {
                                            return Padding(
                                              padding: EdgeInsets.only(top: 8.w),
                                              child: SizedBox(
                                                height: 14.w,
                                                child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: marks.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Row(
                                                        children: [
                                                          CupertinoButton(
                                                              padding: EdgeInsets.zero,
                                                              onPressed: () {
                                                                context.read<LocationCubit>().updateMark(marks[index].name);
                                                                setState(() {
                                                                  _markEditingController.text = marks[index].name;
                                                                });
                                                              },
                                                              child: Text(marks[index].name, style: AppStyles.gilroyRegularGreen(12.sp),)),
                                                          SizedBox(width: 16.w,)
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 9.w,),
                        AnimatedSize(
                          duration: AppConstants.duration200,
                          curve: Curves.easeInOut,
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 9.w),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: AppColors.lightGrey1,),
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.lightPink
                            ),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(height: 2.w,),
                                  BlocBuilder<CategoryCubit, CategoryState>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        controller: _categoryEditingController,
                                        maxLength: 30,
                                        style: AppStyles.gilroyRegularBlack(12.sp),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true,
                                            hintText: 'Category',
                                            hintStyle: AppStyles.gilroyRegularLightGrey2(12.sp),
                                            suffixIconConstraints: BoxConstraints(
                                              maxWidth: 14.w,
                                              maxHeight: 14.w,
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isCategoryPressed = !_isCategoryPressed;
                                                });
                                              },
                                              behavior: HitTestBehavior.opaque,
                                              child: SizedBox(
                                                width: 14.w,
                                                height: 14.w,
                                                child: _isCategoryPressed ?
                                                SvgPicture.asset('assets/icons/up.svg') :
                                                SvgPicture.asset('assets/icons/down.svg'),
                                              ),
                                            )
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            final String resultValue = value.startsWith('#') ? value : '#$value';
                                            context.read<LocationCubit>().updateCategory(resultValue);
                                            context.read<CategoryCubit>().updateName(resultValue);
                                            _categoryEditingController.text = resultValue;
                                          }

                                        },
                                        onFieldSubmitted: (value) async {
                                          if (value.isNotEmpty) {
                                            if (context.read<EntitiesCubit>().state.categories.firstWhereOrNull((e) => e.name == value) == null) {
                                              await context.read<EntitiesCubit>().addCategory(state);
                                            }

                                            if (context.mounted) {
                                              setState(() {
                                                _isCategoryPressed = true;
                                              });
                                            }
                                          }
                                        },
                                        buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  if (_isCategoryPressed)
                                    Column(
                                      children: [
                                        SizedBox(height: 6.w,),
                                        Divider(
                                          height: 1,
                                          color: AppColors.lightGrey1,
                                        ),
                                        BlocSelector<EntitiesCubit, EntitiesState, List<CategoryState>>(
                                          selector: (state) => state.categories,
                                          builder: (context, categories) {
                                            return Padding(
                                              padding: EdgeInsets.only(top: 8.w),
                                              child: SizedBox(
                                                height: 14.w,
                                                child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: categories.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Row(
                                                        children: [
                                                          CupertinoButton(
                                                              padding: EdgeInsets.zero,
                                                              onPressed: () {
                                                                context.read<LocationCubit>().updateCategory(categories[index].name);
                                                                setState(() {
                                                                  _categoryEditingController.text = categories[index].name;
                                                                });
                                                              },
                                                              child: Text(categories[index].name, style: AppStyles.gilroyRegularGreen(12.sp),)),
                                                          SizedBox(width: 16.w,)
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 54.w,),
                  BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                      return YellowBtn(
                          text: 'Search',
                          isActive: _isSaveBtnActive,
                          onPressed: () {
                            context.read<EntitiesCubit>().addLocation(state);
                            Navigator.of(context).pop();
                          });
                    },
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
