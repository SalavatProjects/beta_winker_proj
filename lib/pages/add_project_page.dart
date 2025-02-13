import 'package:beta_winker_proj/bloc/diary_cubit.dart';
import 'package:beta_winker_proj/bloc/project_cubit.dart';
import 'package:beta_winker_proj/bloc/project_cubit.dart';
import 'package:beta_winker_proj/storages/models/project.dart';
import 'package:beta_winker_proj/storages/models/project.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../bloc/entities_cubit.dart';
import '../ui_kit/app_colors.dart';
import '../ui_kit/app_styles.dart';
import '../utils/constants.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController = TextEditingController();

  bool _isSaveBtnActive = false;

  void _checkIsSaveBtnActive() {
    setState(() {
      if (
      context.read<ProjectCubit>().state.name.isNotEmpty &&
      context.read<ProjectCubit>().state.description.isNotEmpty
      ) {
        _isSaveBtnActive = true;
      } else {
        _isSaveBtnActive = false;
      }
    });
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _descriptionEditingController.dispose();
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
                        Container(
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
                              controller: _nameTextEditingController,
                              style: AppStyles.gilroyRegularBlack(12.sp),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  hintText: 'Project name',
                                  hintStyle: AppStyles.gilroyRegularLightGrey2(12.sp)
                              ),
                              onChanged: (value) {
                                context.read<ProjectCubit>().updateName(value);
                                _checkIsSaveBtnActive();
                              },
                              buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                                return null;
                              },
                            ),
                          ),
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
                              context.read<ProjectCubit>().updateDescription(value);
                              _checkIsSaveBtnActive();
                            },
                            buildCounter: (context, {required currentLength, required maxLength, required isFocused}) {
                              return null;
                            },
                          ),
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
                              Text('Link to diary', style: AppStyles.gilroyRegularLightGrey2(12.sp),),
                              BlocSelector<ProjectCubit, ProjectState, List<int>>(
                                selector: (state) => state.diaryIds,
                                builder: (context, diaryIds) {
                                  return PullDownButton(
                                    routeTheme: PullDownMenuRouteTheme(
                                        width: MediaQuery.of(context).size.width * 0.6
                                    ),
                                    itemBuilder: (context) {
                                      final List<DiaryState> diaries = context.read<EntitiesCubit>().state.diaries;
                                      if (diaries.isNotEmpty) {
                                        return List.generate(diaries.length, (int index) {
                                          bool isIdContain = diaryIds.any((id) => diaries[index].id == id);
                                          return PullDownMenuItem(
                                            onTap: () {
                                              if (isIdContain) {
                                                context.read<ProjectCubit>().removeDiaryId(diaries[index].id!);
                                              } else {
                                                context.read<ProjectCubit>().addDiaryId(diaries[index].id!);
                                              }
                                            },
                                            title: diaries[index].subject,
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
                                              title: 'No diaries created yet',
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
                  BlocBuilder<ProjectCubit, ProjectState>(
                    builder: (context, state) {
                      return YellowBtn(
                          text: 'Save',
                          isActive: _isSaveBtnActive,
                          onPressed: () async {
                            await context.read<EntitiesCubit>().addProject(state);
                            if (!context.mounted) return;
                            List<ProjectState> projects = context.read<EntitiesCubit>().state.projects;
                            for (var project in projects) {
                              for (var diaryId in project.diaryIds) {
                                await context.read<EntitiesCubit>().updateDiaryProjectIds(diaryId, project.id!);
                              }
                            }
                            if (!context.mounted) return;
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
