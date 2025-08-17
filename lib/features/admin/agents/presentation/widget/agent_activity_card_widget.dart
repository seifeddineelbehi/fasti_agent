// widgets/agent_activity_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';

class AgentActivityCardWidget extends StatelessWidget {
  final AgentModel agent;

  const AgentActivityCardWidget({
    super.key,
    required this.agent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timeline, color: Colors.orange[600]),
                SizedBox(width: 8.w),
                Text(
                  'Activity Timeline',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            
            // Activity items
            _buildActivityItem(
              'Agent Created',
              '${agent.createdAt.day}/${agent.createdAt.month}/${agent.createdAt.year}',
              Icons.person_add,
              Colors.blue,
            ),
            
            if (agent.lastLoginAt != null)
              _buildActivityItem(
                'Last Login',
                '${agent.lastLoginAt!.day}/${agent.lastLoginAt!.month}/${agent.lastLoginAt!.year}',
                Icons.login,
                Colors.green,
              ),
            
            _buildActivityItem(
              'Current Status',
              agent.isActive ? 'Active' : 'Inactive',
              agent.isActive ? Icons.check_circle : Icons.block,
              agent.isActive ? Colors.green : Colors.red,
            ),
            
            _buildActivityItem(
              'Permissions Updated',
              'Most recent role assignment',
              Icons.security,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}