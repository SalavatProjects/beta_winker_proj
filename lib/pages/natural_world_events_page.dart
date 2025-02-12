import 'package:beta_winker_proj/pages/nature_event_page.dart';
import 'package:beta_winker_proj/ui_kit/app_colors.dart';
import 'package:beta_winker_proj/ui_kit/app_styles.dart';
import 'package:beta_winker_proj/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beta_winker_proj/ui_kit/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class NaturalWorldEventsPage extends StatelessWidget {
  const NaturalWorldEventsPage({super.key});

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
              CustomAppBar(text: 'Events in the natural world'),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 14.w,),
                        Text('January, 2025', style: AppStyles.gilroyMediumBlack(15.sp),),
                        SizedBox(height: 10.w,),
                        _WideCard(
                            imagePath: 'assets/images/deforestation.png',
                            title: 'Deforestation as an environmental problem',
                            date: '05.09.2024',
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  NatureEventPage(
                                      imagePath: 'assets/images/deforestation.png',
                                      head: AppConstants.natureEvents[0].$1,
                                      text: AppConstants.natureEvents[0].$2,
                                      date: '05.09.2024'))
                            )
                        ),
                        SizedBox(height: 12.w,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SquareCard(
                                imagePath: 'assets/images/nature_management.png',
                                title: 'Fundamentals of nature management and environmental protection',
                                date: '05.09.2024',
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) =>
                                        NatureEventPage(
                                            imagePath: 'assets/images/nature_management.png',
                                            head: AppConstants.natureEvents[1].$1,
                                            text: AppConstants.natureEvents[1].$2,
                                            date: '05.09.2024'))
                                ),
                            ),
                            _SquareCard(
                              imagePath: 'assets/images/ecological problems.png',
                              title: 'Ecological problems of our time',
                              date: '05.09.2024',
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) =>
                                      NatureEventPage(
                                          imagePath: 'assets/images/ecological problems.png',
                                          head: AppConstants.natureEvents[2].$1,
                                          text: AppConstants.natureEvents[2].$2,
                                          date: '05.09.2024'))
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12.w,),
                    CupertinoButton(
                      onPressed: () async {
                        if (!await launchUrl(Uri.parse('https://www.youtube.com/watch?v=F_7ZoAQ3aJM'))) {
                          throw Exception('Could not launch url');
                        }
                      },
                      padding: EdgeInsets.zero,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              image: DecorationImage(image: AssetImage('assets/images/tree.png'), fit: BoxFit.fill)
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [AppColors.green, Colors.transparent])
                            ),
                            padding: EdgeInsets.all(10.w),
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 45.w,
                                    height: 45.w,
                                    child: SvgPicture.asset('assets/icons/Play.svg'),
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                      ),
                    ),
                        SizedBox(height: 14.w,),
                        Text('December, 2024', style: AppStyles.gilroyMediumBlack(15.sp),),
                        SizedBox(height: 10.w,),
                        _WideCard(
                            imagePath: 'assets/images/ecology.png',
                            title: 'The Fragile Balance of Earth\'s Ecosystems',
                            date: '17.03.2024',
                            onPressed: () =>
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) =>
                                        NatureEventPage(
                                            imagePath: 'assets/images/ecology.png',
                                            head: AppConstants.natureEvents[3].$1,
                                            text: AppConstants.natureEvents[3].$2,
                                            date: '17.03.2024'))
                                ),
                        ),
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

class _WideCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final void Function() onPressed;

  const _WideCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 140.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.green, Colors.transparent])
          ),
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(title.toUpperCase(), style: AppStyles.gilroySemiBoldWhite(15.sp),),
              ),
              SizedBox(height: 2.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date, style: AppStyles.gilroyRegularLightGrey2(9.sp),),
                  CupertinoButton(
                      onPressed: onPressed,
                      padding: EdgeInsets.zero,
                      sizeStyle: CupertinoButtonSize.small,
                      child: SizedBox(
                        width: 80.w,
                        child: Row(
                          children: [
                            Text('Read more ', style: AppStyles.gilroyRegularWhite(12.sp),),
                            SvgPicture.asset(
                              'assets/icons/Right.svg',
                              colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                              width: 14.w,)
                          ],
                        ),
                      ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

class _SquareCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final void Function() onPressed;

  const _SquareCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 34.w,
        height: 140.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.green, Colors.transparent])
          ),
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(title.toUpperCase(), style: AppStyles.gilroySemiBoldWhite(8.sp),),
              ),
              SizedBox(height: 2.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date, style: AppStyles.gilroyRegularLightGrey2(7.sp),),
                  CupertinoButton(
                      onPressed: onPressed,
                      padding: EdgeInsets.zero,
                      sizeStyle: CupertinoButtonSize.small,
                      child: SizedBox(
                        width: 44.w,
                        child: Row(
                          children: [
                            Text('Read more ', style: AppStyles.gilroyRegularWhite(7.sp),),
                            SvgPicture.asset(
                              'assets/icons/Right.svg',
                              colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                              width: 9.w,)
                          ],
                        ),
                      ))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
