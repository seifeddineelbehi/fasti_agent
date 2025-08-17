import 'package:fasti_dashboard/core/components/custom_buttons.dart';
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final authNotifier = ref.read(authNotifierProvider.notifier);

    final success = await authNotifier.loginAgent(
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    final authState = ref.read(authNotifierProvider);

    if (success) {
      // Navigate to the first available page based on permissions
      final userPermissions = authState.currentUserPermissions;
      String redirectRoute = '/users'; // Default fallback

      // Determine first accessible route based on permissions
      if (userPermissions.contains('view_cars')) {
        redirectRoute = '/cars';
      } else if (userPermissions.contains('view_users')) {
        redirectRoute = '/users';
      } else if (userPermissions.contains('view_drivers')) {
        redirectRoute = '/drivers';
      } else if (userPermissions.contains('view_trips')) {
        redirectRoute = '/trips';
      } else if (userPermissions.contains('view_rentals')) {
        redirectRoute = '/rents_requests';
      } else if (userPermissions.contains('view_agents')) {
        redirectRoute = '/agents';
      } else {
        redirectRoute = '/settings'; // Settings is always available
      }

      context.go(redirectRoute);
    } else if (authState.failure != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authState.failure!.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);

    // Get screen size info
    final isTabletOrDesktop = ScreenUtil().screenWidth > 600.w;
    final isMobile = ScreenUtil().screenWidth <= 600.w;

    return Scaffold(
      backgroundColor: Palette.whiteColor,
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isTabletOrDesktop ? 500.w : double.infinity,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.w : 32.w,
            vertical: isMobile ? 16.h : 32.h,
          ),
          child: Card(
            elevation: isTabletOrDesktop ? 8 : 4,
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 24.w : 32.w),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Agent Icon
                      Icon(
                        Icons.support_agent,
                        size: isMobile ? 64.sp : 80.sp,
                        color: Palette.mainDarkColor,
                      ),
                      SizedBox(height: isMobile ? 16.h : 24.h),

                      // Welcome Text
                      Text(
                        'Agent Portal',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Palette.blackColor,
                          fontSize: isMobile ? 28.sp : 32.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),

                      Text(
                        'Sign in to access your dashboard',
                        style: TextStyle(
                          fontSize: isMobile ? 14.sp : 16.sp,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 32.h : 40.h),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(fontSize: 14.sp),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 20.sp,
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14.sp),
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            size: 20.sp,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 20.sp,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32.h),

                      // Login Button
                      CustomButtons.simpleLongButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        text: 'Sign In',
                        isLoading: _isLoading,
                      ),

                      SizedBox(height: 24.h),

                      // Help Text
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.blue[600],
                                  size: 16.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Need Help?',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue[800],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Contact your administrator if you need access or have forgotten your password.',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}