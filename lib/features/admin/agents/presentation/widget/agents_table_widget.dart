// widgets/agents_table_widget.dart
import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/riverpod/agents_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentsTableWidget extends ConsumerWidget {
  final List<AgentModel> agents;

  const AgentsTableWidget({
    super.key,
    required this.agents,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Agent')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Role')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Permissions')),
          DataColumn(label: Text('Created')),
          DataColumn(label: Text('Last Login')),
          DataColumn(label: Text('Actions')),
        ],
        rows: agents.map((agent) {
          return DataRow(
            onSelectChanged: (_) =>
                AgentPageRoute(agentId: agent.id).go(context),
            cells: [
              DataCell(_buildAgentCell(agent)),
              DataCell(Text(agent.email)),
              DataCell(_buildRoleCell(agent.role)),
              DataCell(_buildStatusCell(agent.isActive)),
              DataCell(Text('${agent.permissions.length} permissions')),
              DataCell(_buildDateCell(agent.createdAt)),
              DataCell(_buildLastLoginCell(agent.lastLoginAt)),
              DataCell(_buildActionsCell(context, ref, agent)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAgentCell(AgentModel agent) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.blue[100],
          backgroundImage:
              agent.photoUrl.isNotEmpty ? NetworkImage(agent.photoUrl) : null,
          child: agent.photoUrl.isEmpty
              ? Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.blue[600],
                )
              : null,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${agent.firstName} ${agent.lastName}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              agent.phone,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleCell(String role) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: _getRoleColor(role).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _formatRoleName(role),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _getRoleColor(role),
        ),
      ),
    );
  }

  Widget _buildStatusCell(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.green[800] : Colors.red[800],
        ),
      ),
    );
  }

  Widget _buildDateCell(DateTime date) {
    return Text('${date.day}/${date.month}/${date.year}');
  }

  Widget _buildLastLoginCell(DateTime? lastLogin) {
    return Text(
      lastLogin != null
          ? '${lastLogin.day}/${lastLogin.month}/${lastLogin.year}'
          : 'Never',
    );
  }

  Widget _buildActionsCell(
      BuildContext context, WidgetRef ref, AgentModel agent) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // IconButton(
        //   icon: const Icon(Icons.visibility, size: 18),
        //   onPressed: () {
        //     AgentPageRoute(agentId: agent.id).go(context);
        //   },
        //   tooltip: 'View Details',
        // ),
        IconButton(
          icon: Icon(
            agent.isActive ? Icons.block : Icons.check_circle,
            size: 18,
          ),
          onPressed: () {
            _toggleAgentStatus(context, ref, agent);
          },
          tooltip: agent.isActive ? 'Deactivate Agent' : 'Activate Agent',
        ),
        IconButton(
          icon: const Icon(Icons.edit, size: 18),
          onPressed: () {
            _editAgent(context, agent);
          },
          tooltip: 'Edit Agent',
        ),
        IconButton(
          icon: const Icon(Icons.delete, size: 18, color: Colors.red),
          onPressed: () {
            _deleteAgent(context, ref, agent);
          },
          tooltip: 'Delete Agent',
        ),
      ],
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'super_admin':
        return Colors.purple;
      case 'car_agent':
        return Colors.blue;
      case 'trip_agent':
        return Colors.green;
      case 'user_support_agent':
        return Colors.orange;
      case 'driver_manager':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  String _formatRoleName(String role) {
    return role
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void _toggleAgentStatus(
      BuildContext context, WidgetRef ref, AgentModel agent) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(agent.isActive ? 'Deactivate Agent' : 'Activate Agent'),
        content: Text(
          agent.isActive
              ? 'Are you sure you want to deactivate ${agent.firstName} ${agent.lastName}? They will lose access to the system.'
              : 'Are you sure you want to activate ${agent.firstName} ${agent.lastName}? They will regain access to the system.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: agent.isActive ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text(agent.isActive ? 'Deactivate' : 'Activate'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(agentsNotifierProvider.notifier)
          .toggleAgentStatus(agentId: agent.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Agent ${agent.isActive ? 'deactivated' : 'activated'} successfully!',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _editAgent(BuildContext context, AgentModel agent) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit agent functionality coming soon!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _deleteAgent(
      BuildContext context, WidgetRef ref, AgentModel agent) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Agent'),
        content: Text(
          'Are you sure you want to delete ${agent.firstName} ${agent.lastName}? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(agentsNotifierProvider.notifier)
          .deleteAgent(agentId: agent.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Agent deleted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}
