import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasti_dashboard/features/admin/agents/data/model/agent_model.dart';
import 'package:fasti_dashboard/features/auth/data/model/admin_model.dart';
import 'package:fasti_dashboard/features/auth/data/model/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
@singleton
class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;
  static const String _collection = 'admin';

  AuthRemoteDataSource(this._firebaseAuth, this._fireStore);

  Future<AuthUserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return AuthUserModel.fromFirebaseUser(user);
    }
    return null;
  }

  Future<bool> userExists(String userId) async {
    final doc = await _fireStore.collection(_collection).doc(userId).get();
    return doc.exists;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<AuthUserModel?> login(
      {required String email, required String password}) async {
    try {
      // First, authenticate with Firebase Auth
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Authentication failed - no user returned');
      }

      // Then fetch admin data from Firestore using the user's UID
      final DocumentSnapshot adminDoc =
          await _fireStore.collection(_collection).doc(user.uid).get();

      AdminModel? admin;
      if (adminDoc.exists) {
        final data = adminDoc.data() as Map<String, dynamic>;
        // Add the document ID to the data
        data['id'] = adminDoc.id;
        admin = AdminModel.fromJson(data);
      }

      return AuthUserModel.fromFirebaseUser(user, admin: admin);
    } catch (e) {
      rethrow; // Let the repository handle the error
    }
  }

  Future<AdminModel?> getAdminById(String userId) async {
    final doc = await _fireStore.collection(_collection).doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return AdminModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<AgentModel?> getAgentById(String agentId) async {
    try {
      final doc = await _fireStore.collection('agents').doc(agentId).get();

      if (doc.exists && doc.data() != null) {
        return AgentModel.fromJson({
          'id': doc.id,
          ...doc.data()!,
        });
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get agent: $e');
    }
  }

  /// Get agent by email
  Future<AgentModel?> getAgentByEmail(String email) async {
    try {
      final querySnapshot = await _fireStore
          .collection('agents')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return AgentModel.fromJson({
          'id': doc.id,
          ...doc.data(),
        });
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get agent by email: $e');
    }
  }

  /// Update agent's last login timestamp
  Future<void> updateAgentLastLogin(String agentId) async {
    try {
      await _fireStore.collection('agents').doc(agentId).update({
        'lastLoginAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to update last login: $e');
    }
  }

  /// Check if agent exists and is active
  Future<bool> isAgentActiveById(String agentId) async {
    try {
      final doc = await _fireStore.collection('agents').doc(agentId).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return data['isActive'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Verify agent credentials (for additional security if needed)
  Future<bool> verifyAgentCredentials(String email, String agentId) async {
    try {
      final agent = await getAgentById(agentId);
      return agent != null &&
          agent.email.toLowerCase() == email.toLowerCase() &&
          agent.isActive;
    } catch (e) {
      return false;
    }
  }

  /// Get agent permissions by ID
  Future<List<String>> getAgentPermissions(String agentId) async {
    try {
      final agent = await getAgentById(agentId);
      return agent?.permissions ?? [];
    } catch (e) {
      return [];
    }
  }

  /// Update agent activity status
  Future<void> updateAgentStatus(String agentId, bool isActive) async {
    try {
      await _fireStore.collection('agents').doc(agentId).update({
        'isActive': isActive,
      });
    } catch (e) {
      throw Exception('Failed to update agent status: $e');
    }
  }
}
