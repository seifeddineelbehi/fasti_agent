import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:fasti_dashboard/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const NavigationAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);

    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.support_agent,
            color: Palette.mainDarkColor,
          ),
          const SizedBox(width: 8),
          Text(
            MyApp.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 1,
      actions: [
        // Agent Info
        if (authState.agent != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Agent Avatar
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Palette.mainDarkColor,
                  backgroundImage: authState.agent!.photoUrl.isNotEmpty
                      ? NetworkImage(authState.agent!.photoUrl)
                      : null,
                  child: authState.agent!.photoUrl.isEmpty
                      ? Text(
                          authState.agent!.firstName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 8),

                // Agent Name and Role
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authState.agentFullName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _formatRole(authState.agentRole),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),

                // Simplified Dropdown Menu (removed settings option)
                PopupMenuButton<String>(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onSelected: (value) async {
                    switch (value) {
                      case 'profile':
                        _showProfileDialog(context, ref);
                        break;
                      case 'refresh_permissions':
                        await ref
                            .read(authNotifierProvider.notifier)
                            .refreshAgentPermissions();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Permissions refreshed'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        break;
                      case 'logout':
                        _showLogoutDialog(context, ref);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'profile',
                      child: ListTile(
                        leading: Icon(Icons.person_outline),
                        title: Text('Profile'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'refresh_permissions',
                      child: ListTile(
                        leading: Icon(Icons.refresh),
                        title: Text('Refresh Permissions'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      value: 'logout',
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text('Sign Out',
                            style: TextStyle(color: Colors.red)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _formatRole(String role) {
    return role
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void _showProfileDialog(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authNotifierProvider);
    final agent = authState.agent!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agent Profile'),
        content: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Palette.mainDarkColor,
                  backgroundImage: agent.photoUrl.isNotEmpty
                      ? NetworkImage(agent.photoUrl)
                      : null,
                  child: agent.photoUrl.isEmpty
                      ? Text(
                          agent.firstName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              // Agent Details
              _buildProfileRow('Name', '${agent.firstName} ${agent.lastName}'),
              _buildProfileRow('Email', agent.email),
              _buildProfileRow('Phone', agent.phone),
              _buildProfileRow('Role', _formatRole(agent.role)),
              _buildProfileRow(
                  'Status', agent.isActive ? 'Active' : 'Inactive'),

              const SizedBox(height: 12),
              const Text(
                'Access Permissions:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),

              // Show permissions with better formatting
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: agent.permissions.map((permission) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getPermissionColor(permission),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _formatPermission(permission),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Color _getPermissionColor(String permission) {
    if (permission == 'view_dashboard') return Colors.purple;
    if (permission.startsWith('view_')) return Colors.blue;
    if (permission.startsWith('add_') || permission.startsWith('create_'))
      return Colors.green;
    if (permission.startsWith('edit_') || permission.startsWith('approve_'))
      return Colors.orange;
    if (permission.startsWith('delete_') || permission.startsWith('ban_'))
      return Colors.red;
    return Colors.grey;
  }

  String _formatPermission(String permission) {
    return permission.replaceAll('_', ' ').toUpperCase();
  }

  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(authNotifierProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
