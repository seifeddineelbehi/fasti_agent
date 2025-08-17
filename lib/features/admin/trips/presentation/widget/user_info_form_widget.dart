import 'package:fasti_dashboard/core/components/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const UserInfoFormWidget({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
  });

  @override
  State<UserInfoFormWidget> createState() => _UserInfoFormWidgetState();
}

class _UserInfoFormWidgetState extends State<UserInfoFormWidget> {
  late FocusNode _firstNameFocus;
  late FocusNode _lastNameFocus;
  late FocusNode _phoneFocus;
  late FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();
    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _phoneFocus = FocusNode();
    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.textBoldWeight600(
            text: "User Information",
            fontSize: 18.sp,
            color: Colors.black,
          ),
          SizedBox(height: 16.sp),

          // First Name and Last Name Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.textBoldWeight500(
                      text: "First Name *",
                      fontSize: 14.sp,
                      color: Colors.grey[700]!,
                    ),
                    SizedBox(height: 8.sp),
                    TextFormField(
                      controller: widget.firstNameController,
                      focusNode: _firstNameFocus,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_lastNameFocus);
                      },
                      decoration: InputDecoration(
                        hintText: "Enter first name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: Colors.blue[600]!),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.sp,
                          vertical: 12.sp,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.sp),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.textBoldWeight500(
                      text: "Last Name *",
                      fontSize: 14.sp,
                      color: Colors.grey[700]!,
                    ),
                    SizedBox(height: 8.sp),
                    TextFormField(
                      controller: widget.lastNameController,
                      focusNode: _lastNameFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneFocus);
                      },
                      decoration: InputDecoration(
                        hintText: "Enter last name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          borderSide: BorderSide(color: Colors.blue[600]!),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.sp,
                          vertical: 12.sp,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.sp),

          // Phone Number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.textBoldWeight500(
                text: "Phone Number *",
                fontSize: 14.sp,
                color: Colors.grey[700]!,
              ),
              SizedBox(height: 8.sp),
              TextFormField(
                controller: widget.phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocus);
                },
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(color: Colors.blue[600]!),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.sp,
                    vertical: 12.sp,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  if (value.length < 8) {
                    return 'Phone number must be at least 8 digits';
                  }
                  return null;
                },
              ),
            ],
          ),

          SizedBox(height: 16.sp),

          // Email (Optional)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.textBoldWeight500(
                text: "Email (Optional)",
                fontSize: 14.sp,
                color: Colors.grey[700]!,
              ),
              SizedBox(height: 8.sp),
              TextFormField(
                controller: widget.emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Enter email address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(color: Colors.blue[600]!),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.sp,
                    vertical: 12.sp,
                  ),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
