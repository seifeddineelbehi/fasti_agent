import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // Timer(const Duration(seconds: 3), () async {
    //   context.pushReplacementNamed(AppRoutes.welcomingPage);
    // });
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash delay
    context.go(AppRoutes.dashboardPage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.mainColor,
        image: DecorationImage(
          image: AssetImage("assets/images/splashbackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        // Centering the image
        child: SizedBox(
          width: 180.sp,
          height: 180.sp,
          child: Assets.svgs.logo.svg(
            fit: BoxFit.contain,
            color: Palette.whiteColor,
          ),
        ),
      ),
    );
  }
}
