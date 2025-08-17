// widgets/agent_info_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';

class AgentInfoCardWidget extends StatelessWidget {
  final AgentModel agent;

  const AgentInfoCardWidget({
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
                Icon(Icons.info_outline, color: Colors.blue[600]),
                SizedBox(width: 8.w),
                Text(
                  'Agent Information',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            
            _buildInfoRow('First Name', agent.firstName),
            _buildInfoRow('Last Name', agent.lastName),
            _buildInfoRow('Email', agent.email),
            _buildInfoRow('Phone', agent.phone),
            _buildInfoRow('Role', _formatRoleName(agent.role)),
            _buildInfoRow('Status', agent.isActive ? 'Active' : 'Inactive'),
            _buildInfoRow('Created At', 
                '${agent.createdAt.day}/${agent.createdAt.month}/${agent.createdAt.year}'),
            if (agent.lastLoginAt != null)
              _buildInfoRow('Last Login', 
                  '${agent.lastLoginAt!.day}/${agent.lastLoginAt!.month}/${agent.lastLoginAt!.year}'),
            _buildInfoRow('Created By', agent.createdByAdminName),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatRoleName(String role) {
    return role.split('_').map((word) => 
        word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}