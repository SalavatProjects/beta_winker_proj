import 'package:beta_winker_proj/bloc/diary_cubit.dart';
import 'package:beta_winker_proj/bloc/entities_cubit.dart';
import 'package:beta_winker_proj/bloc/mark_cubit.dart';
import 'package:beta_winker_proj/bloc/project_cubit.dart';
import 'package:beta_winker_proj/utils/constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:beta_winker_proj/ui_kit/ui_kit.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../bloc/category_cubit.dart';


class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage({super.key});

  @override
  State<AddDiaryPage> createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  final TextEditingController _subjectTextEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController = TextEditingController();
  final TextEditingController _markEditingController = TextEditingController();
  final TextEditingController _categoryEditingController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? _video;

  bool _isMarkPressed = false;
  bool _isCategoryPressed = false;
  bool _isSaveBtnActive = false;


  void _checkIsSaveBtnActive() {
    setState(() {
      if (
      context.read<DiaryCubit>().state.subject.isNotEmpty &&
          context.read<DiaryCubit>().state.date != null &&
          context.read<DiaryCubit>().state.description.isNotEmpty &&
          context.read<DiaryCubit>().state.imagePath.isNotEmpty
      ) {
        _isSaveBtnActive = true;
      } else {
        _isSaveBtnActive = false;
      }
    });
  }

  @override
  void dispose() {
    _subjectTextEditingController.dispose();
    _descriptionEditingController.dispose();
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
                  CustomAppBar(text: 'New entries'),
                  SizedBox(height: 20.w,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 32.w,
                                padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 9.w),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: AppColors.lightGrey1,),
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: AppColors.lightPink
                                ),
                                child: Center(
                                  child: TextFormField(
                                    maxLength: 40,
                                    controller: _subjectTextEditingController,
                                    style: AppStyles.gilroyRegularBlack(12.sp),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      hintText: 'Subject of observation',
                                      hintStyle: AppStyles.gilroyRegularLightGrey2(12.sp)
                                    ),
                                    onChanged: (value) {
                                      context.read<DiaryCubit>().updateSubject(value);
                                      _checkIsSaveBtnActive();
                                    },
                                    buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 11.w,),
                            BlocSelector<DiaryCubit, DiaryState, DateTime?>(
                            selector: (state) => state.date,
                            builder: (context, date) {
                              return CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(2074));
                                if (pickedDate != null) {
                                  if (!context.mounted) return;
                                  context.read<DiaryCubit>().updateDate(DateUtils.dateOnly(pickedDate));
                                }
                                _checkIsSaveBtnActive();
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
                                    Text(date != null ? DateFormat('dd.MM.yyyy').format(date) : '00.00.0000', style: AppStyles.gilroyRegularLightGrey2(13.sp),)
                                  ],
                                ),
                              ),
                            );
                            },
                          ),
                          ],
                        ),
                        SizedBox(height: 9.w,),
                        Container(
                          height: 94.w,
                          padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 9.w),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: AppColors.lightGrey1,),
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColors.lightPink
                          ),
                          child: TextFormField(
                            controller: _descriptionEditingController,
                            maxLines: 5,
                            style: AppStyles.gilroyRegularBlack(12.sp),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                hintText: 'Description',
                                hintStyle: AppStyles.gilroyRegularLightGrey2(12.sp)
                            ),
                            onChanged: (value) {
                              context.read<DiaryCubit>().updateDescription(value);
                              _checkIsSaveBtnActive();
                            },
                            buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                              return null;
                            },
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
                                        context.read<DiaryCubit>().updateMark(resultValue);
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
                                                                  context.read<DiaryCubit>().updateMark(marks[index].name);
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
                                            context.read<DiaryCubit>().updateCategory(resultValue);
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
                                                                context.read<DiaryCubit>().updateCategory(categories[index].name);
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
                        SizedBox(height: 9.w,),
                        Text('Add files', style: AppStyles.gilroyRegularGrey2(12.sp),),
                        SizedBox(height: 9.w,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocSelector<DiaryCubit, DiaryState, String>(
                            selector: (state) => state.videoPath,
                            builder: (context, videoPath) {
                              return CupertinoButton(
                                onPressed: () async {
                                  final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

                                  if (video != null) {
                                    if (!context.mounted) return;
                                    context.read<DiaryCubit>().updateVideoPath(video.path);
                                  }
                                },
                                padding: EdgeInsets.zero,
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 - 28.w,
                                  height: 70.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.r),
                                    border: Border.all(width: 1, color: AppColors.lightGrey1),
                                    color: AppColors.lightPink
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 16.w,
                                      child: videoPath.isNotEmpty ? Icon(Icons.check_circle, color: AppColors.lightGrey2,) : SvgPicture.asset('assets/icons/Video.svg'),
                                    ),
                                  ),
                                ),
                            );
                              },
                            ),
                            BlocSelector<DiaryCubit, DiaryState, String>(
                            selector: (state) => state.imagePath,
                            builder: (context, imagePath) {
                              return CupertinoButton(
                              onPressed: () async {
                                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  if (!context.mounted) return;
                                  context.read<DiaryCubit>().updateImagePath(image.path);
                                }
                                _checkIsSaveBtnActive();
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2 - 28.w,
                                height: 70.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.r),
                                    border: Border.all(width: 1, color: AppColors.lightGrey1),
                                    color: AppColors.lightPink
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 16.w,
                                    child: imagePath.isNotEmpty ? Icon(Icons.check_circle, color: AppColors.lightGrey2,) :  SvgPicture.asset('assets/icons/Image.svg'),
                                  ),
                                ),
                              ),
                            );
                            },
                          ),
                          ],
                        ),
                        SizedBox(height: 9.w,),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 9.w),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: AppColors.lightGrey1,),
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColors.lightPink
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Link to project', style: AppStyles.gilroyRegularLightGrey2(12.sp),),
                              BlocSelector<DiaryCubit, DiaryState, List<int>>(
                                selector: (state) => state.projectIds,
                                builder: (context, projectIds) {
                                  return PullDownButton(
                                routeTheme: PullDownMenuRouteTheme(
                                  width: MediaQuery.of(context).size.width * 0.6
                                ),
                                itemBuilder: (context) {
                                  final List<ProjectState> projects = context.read<EntitiesCubit>().state.projects;
                                  if (projects.isNotEmpty) {
                                    return List.generate(projects.length, (int index) {
                                      bool isIdContain = projectIds.any((id) => projects[index].id == id);
                                      return PullDownMenuItem(
                                          onTap: () {
                                            if (isIdContain) {
                                              context.read<DiaryCubit>().removeProjectId(projects[index].id!);
                                            } else {
                                              context.read<DiaryCubit>().addProjectId(projects[index].id!);
                                            }
                                          },
                                          title: projects[index].name,
                                          itemTheme: PullDownMenuItemTheme(
                                            textStyle: AppStyles.gilroyMediumGrey1(12.sp)
                                          ),
                                        iconWidget: isIdContain ? Icon(Icons.check) : SizedBox.shrink(),
                                      );
                                    }
                                    );
                                  } else {
                                    return List.generate(1, (int index) =>
                                      PullDownMenuItem(
                                          onTap: () {},
                                          title: 'No projects created yet',
                                          itemTheme: PullDownMenuItemTheme(
                                            textStyle: AppStyles.gilroyMediumGrey1(12.sp)
                                          ),
                                      )
                                    );
                                  }
                                },
                                buttonBuilder: (context, showMenu) {
                                  return GestureDetector(
                                    onTap: showMenu,
                                    behavior: HitTestBehavior.opaque,
                                    child: SizedBox(
                                      width: 14.w,
                                      height: 14.w,
                                      child: SvgPicture.asset('assets/icons/down.svg'),
                                    ),
                                  );
                                },
                              );
                              },
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 54.w,),
                  BlocBuilder<DiaryCubit, DiaryState>(
                    builder: (context, state) {
                      return YellowBtn(
                      text: 'Save',
                      isActive: _isSaveBtnActive,
                      onPressed: () {
                        context.read<EntitiesCubit>().addDiary(state);
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
