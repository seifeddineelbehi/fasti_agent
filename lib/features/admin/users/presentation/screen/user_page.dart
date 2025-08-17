import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/riverpod/users_provider.dart';
import 'package:fasti_dashboard/features/admin/users/presentation/widget/user_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPage extends ConsumerStatefulWidget {
  final String userId;
  const UserPage({super.key, required this.userId});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref
          .read(usersNotifierProvider.notifier)
          .getUserById(userId: widget.userId);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(usersNotifierProvider).user;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Palette.mainDarkColor,
        ),
      );
    } else {
      if (user == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('User Details')),
          body: const Center(child: Text('No user information available')),
        );
      }

      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text('User Details', style: TextStyle(fontSize: 20.sp)),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Header
              buildUserHeader(user),
              SizedBox(height: 24.h),

              // Responsive Grid Layout
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;

                  if (screenWidth > 1200) {
                    // Desktop Layout - 3 columns
                    return Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildUserInfoCard(user)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildUserActivityCard(user)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildUserFavoritesCard(user)),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildUserTransactionsCard(user)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildUserRentalCarsCard(user)),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (screenWidth > 768) {
                    // Tablet Layout - 2 columns
                    return Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildUserInfoCard(user)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildUserActivityCard(user)),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildUserFavoritesCard(user)),
                              SizedBox(width: 16.w),
                              Expanded(child: buildUserTransactionsCard(user)),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: buildUserRentalCarsCard(user)),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child:
                                      Container()), // Empty space for alignment
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Mobile Layout - 1 column
                    return Column(
                      children: [
                        buildUserInfoCard(user),
                        SizedBox(height: 16.h),
                        buildUserActivityCard(user),
                        SizedBox(height: 16.h),
                        buildUserFavoritesCard(user),
                        SizedBox(height: 16.h),
                        buildUserTransactionsCard(user),
                        SizedBox(height: 16.h),
                        buildUserRentalCarsCard(user),
                        SizedBox(height: 16.h),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
