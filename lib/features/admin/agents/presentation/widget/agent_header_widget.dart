// widgets/agent_header_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';

class AgentHeaderWidget extends StatelessWidget {
  final AgentModel agent;

  const AgentHeaderWidget({
    super.key,
    required this.agent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Row(
          children: [
            // Agent Avatar
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.blue[100],
              backgroundImage: agent.photoUrl.isNotEmpty
                  ? NetworkImage(agent.photoUrl)
                  : null,
              child: agent.photoUrl.isEmpty
                  ? Icon(
                      Icons.person,
                      size: 40.r,
                      color: Colors.blue[600],
                    )
                  : null,
            ),
            SizedBox(width: 24.w),
            
            // Agent Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${agent.firstName} ${agent.lastName}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    agent.email,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _buildStatusChip(agent.isActive),
                      SizedBox(width: 12.w),
                      _buildRoleChip(agent.role),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.green[800] : Colors.red[800],
        ),
      ),
    );
  }

  Widget _buildRoleChip(String role) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        _formatRoleName(role),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  String _formatRoleName(String role) {
    return role.split('_').map((word) => 
        word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}