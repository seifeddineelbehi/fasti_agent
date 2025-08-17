import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/core/util/palette.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/riverpod/agents_provider.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/widget/agents_filter_widget.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/widget/agents_stats_widget.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/widget/agents_table_widget.dart';
import 'package:fasti_dashboard/widgets/content_view.dart';
import 'package:fasti_dashboard/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class AgentsPage extends ConsumerStatefulWidget {
  const AgentsPage({super.key});

  @override
  ConsumerState<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends ConsumerState<AgentsPage> {
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _roleFilter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLoading = true;
      });

      await ref.read(agentsNotifierProvider.notifier).getAllAgents();
      setState(() {
        isLoading = false;
      });
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final agents = ref.watch(agentsNotifierProvider).agents ?? [];

    // Filter by search query and role
    final filteredAgents = agents.where((agent) {
      final agentName = '${agent.firstName} ${agent.lastName}'.toLowerCase();
      final emailMatch = agent.email.toLowerCase().contains(_searchQuery);
      final nameMatch = agentName.contains(_searchQuery);

      bool matchesSearch = nameMatch || emailMatch;

      bool matchesRole = _roleFilter == 'all' ||
          agent.role.toLowerCase() == _roleFilter.toLowerCase();

      return matchesSearch && matchesRole;
    }).toList();

    final hasActiveFilters = _roleFilter != 'all' || _searchQuery.isNotEmpty;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Palette.mainDarkColor,
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[50],
            body: ContentView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Header with Add Button
                  Row(
                    children: [
                      const Expanded(
                        child: PageHeader(
                          title: 'Agents Management',
                          description:
                              'Manage admin agents and their permissions.',
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          CreateAgentPageRoute().go(context);
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Add New Agent',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.mainDarkColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),

                  // Search and Filter
                  AgentsFilterWidget(
                    searchController: _searchController,
                    roleFilter: _roleFilter,
                    onRoleFilterChanged: (value) {
                      setState(() {
                        _roleFilter = value;
                      });
                    },
                    onClearFilters: () {
                      setState(() {
                        _roleFilter = 'all';
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                    hasActiveFilters: hasActiveFilters,
                  ),
                  const Gap(16),

                  // Stats Cards
                  AgentsStatsWidget(agents: agents),
                  const Gap(16),

                  // Results Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing ${filteredAgents.length} of ${agents.length} agents',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),

                  // Agents Table
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: AgentsTableWidget(
                        agents: filteredAgents,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
