import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:fasti_dashboard/core/util/helper_functions.dart';
import 'package:fasti_dashboard/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/router/router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static const title = 'Fasti Agent Dashboard';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return AdaptiveTheme(
      light: AppTheme.light.copyWith(
        textTheme: AppTheme.light.textTheme.apply(fontFamily: 'Montserrat'),
      ),
      // dark: AppTheme.dark.copyWith(
      //   textTheme: AppTheme.dark.textTheme.apply(fontFamily: 'Montserrat'),
      // ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => ScreenUtilInit(
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        designSize: getDesignSize(MediaQuery.of(context).size.width),
        builder: (contextMain, child) {
          return GestureDetector(
            onTap: () {
              var currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: ResponsiveBreakpoints.builder(
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 960, name: TABLET),
                const Breakpoint(
                    start: 961, end: double.infinity, name: DESKTOP),
              ],
              child: MaterialApp.router(
                scrollBehavior: MyCustomScrollBehavior(),
                title: title,
                routerConfig: router,
                theme: theme,
                darkTheme: darkTheme,
                debugShowCheckedModeBanner: false,
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
