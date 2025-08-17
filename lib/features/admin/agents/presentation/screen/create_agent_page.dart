import 'package:fasti_dashboard/core/router/router.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/create_agent_request_model.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/riverpod/agents_provider.dart';
import 'package:fasti_dashboard/features/admin/agents/presentation/widget/create_agent_form_widget.dart';
import 'package:fasti_dashboard/widgets/content_view.dart';
import 'package:fasti_dashboard/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CreateAgentPage extends ConsumerStatefulWidget {
  const CreateAgentPage({super.key});

  @override
  ConsumerState<CreateAgentPage> createState() => _CreateAgentPageState();
}

class _CreateAgentPageState extends ConsumerState<CreateAgentPage> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(agentsNotifierProvider).isCreatingAgentLoading;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ContentView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(
              title: 'Create New Agent',
              description: 'Add a new agent with specific permissions.',
            ),
            const Gap(24),
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: CreateAgentFormWidget(
                      isLoading: isLoading,
                      onSubmit: _createAgent,
                      onCancel: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createAgent(CreateAgentRequestModel request) async {
    await ref
        .read(agentsNotifierProvider.notifier)
        .createAgent(request: request);

    final failure = ref.read(agentsNotifierProvider).failure;

    if (failure == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Agent created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        AgentsPageRoute().go(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating agent: ${failure.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
