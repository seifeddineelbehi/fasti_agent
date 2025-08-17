// widgets/agents_stats_widget.dart
import 'package:flutter/material.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';

class AgentsStatsWidget extends StatelessWidget {
  final List<AgentModel> agents;

  const AgentsStatsWidget({
    super.key,
    required this.agents,
  });

  @override
  Widget build(BuildContext context) {
    final totalAgents = agents.length;
    final activeAgents = agents.where((a) => a.isActive).length;
    final inactiveAgents = agents.where((a) => !a.isActive).length;
    final carAgents = agents.where((a) => a.role == 'car_agent').length;
    final tripAgents = agents.where((a) => a.role == 'trip_agent').length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Agents',
            totalAgents.toString(),
            Icons.people,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Active Agents',
            activeAgents.toString(),
            Icons.check_circle,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Inactive Agents',
            inactiveAgents.toString(),
            Icons.block,
            Colors.red,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Car Agents',
            carAgents.toString(),
            Icons.directions_car,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Trip Agents',
            tripAgents.toString(),
            Icons.route,
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}