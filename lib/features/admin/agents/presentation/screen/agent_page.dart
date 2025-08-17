// pages/agent_page.dart
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/riverpod/agents_provider.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/widget/agent_header_widget.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/widget/agent_info_card_widget.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/widget/agent_permissions_card_widget.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/widget/agent_activity_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentPage extends ConsumerStatefulWidget {
  final String agentId;
  const AgentPage({super.key, required this.agentId});

  @override
  ConsumerState<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends ConsumerState<AgentPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref
          .read(agentsNotifierProvider.notifier)
          .getAgentById(agentId: widget.agentId);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final agent = ref.watch(agentsNotifierProvider).agent;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Palette.mainDarkColor,
        ),
      );
    }

    if (agent == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Agent Details')),
        body: const Center(child: Text('No agent information available')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Agent Details', style: TextStyle(fontSize: 20.sp)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(agent.isActive ? Icons.block : Icons.check_circle),
            onPressed: _toggleAgentStatus,
            tooltip: agent.isActive ? 'Deactivate Agent' : 'Activate Agent',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editAgent,
            tooltip: 'Edit Agent',
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Agent Profile Header
            AgentHeaderWidget(agent: agent),
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
                            Expanded(child: AgentInfoCardWidget(agent: agent)),
                            SizedBox(width: 16.w),
                            Expanded(child: AgentPermissionsCardWidget(agent: agent)),
                            SizedBox(width: 16.w),
                            Expanded(child: AgentActivityCardWidget(agent: agent)),
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
                            Expanded(child: AgentInfoCardWidget(agent: agent)),
                            SizedBox(width: 16.w),
                            Expanded(child: AgentPermissionsCardWidget(agent: agent)),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      AgentActivityCardWidget(agent: agent),
                    ],
                  );
                } else {
                  // Mobile Layout - 1 column
                  return Column(
                    children: [
                      AgentInfoCardWidget(agent: agent),
                      SizedBox(height: 16.h),
                      AgentPermissionsCardWidget(agent: agent),
                      SizedBox(height: 16.h),
                      AgentActivityCardWidget(agent: agent),
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

  void _toggleAgentStatus() async {
    await ref
        .read(agentsNotifierProvider.notifier)
        .toggleAgentStatus(agentId: widget.agentId);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Agent status updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _editAgent() {
    // Navigate to edit agent page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit agent functionality coming soon!'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}