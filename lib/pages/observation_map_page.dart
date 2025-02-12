import 'package:beta_winker_proj/bloc/location_cubit.dart';
import 'package:beta_winker_proj/pages/add_location_page.dart';
import 'package:beta_winker_proj/ui_kit/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/category_cubit.dart';
import '../bloc/entities_cubit.dart';
import '../bloc/mark_cubit.dart';
import '../ui_kit/app_styles.dart';
import 'filter_page.dart';

class ObservationMapPage extends StatefulWidget {
  const ObservationMapPage({super.key});

  @override
  State<ObservationMapPage> createState() => _ObservationMapPageState();
}

class _ObservationMapPageState extends State<ObservationMapPage> {
  final TextEditingController _searchEditingController = TextEditingController();
  List<LocationState> _currentLocations = [];

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
              CustomAppBar(text: 'Observation map'),
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
                                        setState(() {
                                          _currentLocations = context.read<EntitiesCubit>().state.locations.where((e) => e.name.startsWith(value)).toList();
                                        });
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
                        BlocSelector<EntitiesCubit, EntitiesState, List<LocationState>>(
                          selector: (state) => state.locations,
                          builder: (context, locations) {
                            if(_searchEditingController.text.isEmpty) {
                              _currentLocations = locations;
                            }
                            if (_currentLocations.isNotEmpty) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 7.w,),
                                    ...List.generate(
                                        _currentLocations.length,
                                            (int index) =>
                                            _LocationCard(name: _currentLocations[index].name)
                                    ),
                                    SizedBox(height: 28.w,),
                                    YellowBtn(
                                        text: 'Search',
                                        onPressed: () => Navigator.of(context).push(
                                            MaterialPageRoute(builder: (BuildContext context) =>
                                                MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(create: (context) => LocationCubit()),
                                                    BlocProvider(create: (context) => MarkCubit()),
                                                    BlocProvider(create: (context) => CategoryCubit())
                                                  ],
                                                  child: AddLocationPage(),
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
                                  Text('There are no locations yet', style: AppStyles.gilroyMediumGrey1(15.sp),),
                                  SizedBox(height: 28.w,),
                                  YellowBtn(
                                      text: 'Search',
                                      onPressed: () => Navigator.of(context).push(
                                          MaterialPageRoute(builder: (BuildContext context) =>
                                              MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(create: (context) => LocationCubit()),
                                                  BlocProvider(create: (context) => MarkCubit()),
                                                  BlocProvider(create: (context) => CategoryCubit())
                                                ],
                                                child: AddLocationPage(),
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
              ),
                          ],
          ),
        ),
      ),
    );;
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
