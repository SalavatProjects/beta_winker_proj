import 'package:beta_winker_proj/bloc/project_cubit.dart';
import 'package:beta_winker_proj/pages/add_project_page.dart';
import 'package:beta_winker_proj/pages/project_diaries_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import '../bloc/category_cubit.dart';
import '../bloc/diary_cubit.dart';
import '../bloc/entities_cubit.dart';
import '../bloc/mark_cubit.dart';
import '../ui_kit/app_colors.dart';
import '../ui_kit/app_styles.dart';
import '../utils/constants.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

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
              CustomAppBar(text: 'Projects'),
              BlocSelector<EntitiesCubit, EntitiesState, List<ProjectState>>(
                selector: (state) => state.projects,
                builder: (context, projects) {
                  if (projects.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(
                              projects.length,
                                  (int index) =>
                                  _ProjectCard(
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(builder: (BuildContext context) => ProjectDiariesPage(
                                          projectId: projects[index].id!))
                                    ),
                                    name: projects[index].name,
                                    description: projects[index].description,
                                    onDelete: () {
                                      context.read<EntitiesCubit>().deleteProject(projects[index].id!);
                                    },
                                  )
                          ),
                          SizedBox(height: 28.w,),
                          YellowBtn(
                              text: 'Create projects',
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) =>
                                      MultiBlocProvider(
                                        providers: [
                                          BlocProvider(create: (context) => ProjectCubit()),
                                          BlocProvider(create: (context) => MarkCubit()),
                                          BlocProvider(create: (context) => CategoryCubit())
                                        ],
                                        child: AddProjectPage(),
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
                        Text('There are no projects yet', style: AppStyles.gilroyMediumGrey1(15.sp),),
                        SizedBox(height: 28.w,),
                        YellowBtn(
                            text: 'Create projects',
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) =>
                                    MultiBlocProvider(
                                      providers: [
                                        BlocProvider(create: (context) => ProjectCubit()),
                                        BlocProvider(create: (context) => MarkCubit()),
                                        BlocProvider(create: (context) => CategoryCubit())
                                      ],
                                      child: AddProjectPage(),
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

class _ProjectCard extends StatefulWidget {
  final String name;
  final String description;
  final void Function() onDelete;
  final void Function() onPressed;

  const _ProjectCard({
    super.key,
    required this.name,
    required this.description,
    required this.onDelete,
    required this.onPressed
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isOnDeleteOpen = false;
  final double _onDeleteBtnWidth = 80.w;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: CupertinoButton(
        onPressed: widget.onPressed,
        padding: EdgeInsets.zero,
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
                    children: [
                      SizedBox(
                        width: 246.w,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
      ),
    );
  }
}