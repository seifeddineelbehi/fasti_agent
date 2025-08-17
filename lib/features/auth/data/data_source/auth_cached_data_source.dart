import 'dart:convert';

import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
@singleton
class AuthCachedDataSource {
  final SharedPreferences sharedPreferences;
  static const String _cachedUserKey = 'CACHED_USER';
  static const String _isLoggedInKey = 'IS_LOGGED_IN';

  AuthCachedDataSource(this.sharedPreferences);

  static const String _agentKey = 'cached_agent';
  static const String _agentLoggedInKey = 'agent_logged_in';

  // Cache agent
  Future<void> cacheAgent(AgentModel agent) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final agentJson = jsonEncode(agent.toJson());
      await prefs.setString(_agentKey, agentJson);
      await prefs.setBool(_agentLoggedInKey, true);
    } catch (e) {
      throw Exception('Failed to cache agent: $e');
    }
  }

  static Future<void> staticCacheAgent(AgentModel agent) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final agentJson = jsonEncode(agent.toJson());
      await prefs.setString(_agentKey, agentJson);
      await prefs.setBool(_agentLoggedInKey, true);
    } catch (e) {
      throw Exception('Failed to cache agent: $e');
    }
  }

  // Get cached agent
  Future<AgentModel?> getCachedAgent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final agentJson = prefs.getString(_agentKey);

      if (agentJson != null) {
        final agentMap = jsonDecode(agentJson);
        return AgentModel.fromJson(agentMap);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Static method to get cached agent
  static Future<AgentModel?> getCachedAgentStatic() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final agentJson = prefs.getString(_agentKey);

      if (agentJson != null) {
        final agentMap = jsonDecode(agentJson);
        return AgentModel.fromJson(agentMap);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Check if agent is logged in
  Future<bool> isAgentLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_agentLoggedInKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  // Static method to check if agent is logged in
  static Future<bool> isAgentLoggedInStatic() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_agentLoggedInKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  // Clear agent cache
  Future<void> clearAgentCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_agentKey);
      await prefs.setBool(_agentLoggedInKey, false);
    } catch (e) {
      throw Exception('Failed to clear agent cache: $e');
    }
  }

  // Clear all cache (both admin and agent)
  Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_agentKey);
      await prefs.setBool(_agentLoggedInKey, false);
    } catch (e) {
      throw Exception('Failed to clear all cache: $e');
    }
  }
}
