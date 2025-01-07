import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../utils/failures.dart';
import '../../../../../auth/login/data/model/user_login_model.dart';
import '../../../../../auth/signup/data/model/user_model.dart';

class HomeTabData{


  Future<void> updateBalance(String userId, double newBalance) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(
          userId);

      await userDoc.update({
        'balance': (newBalance),
      });

      print('Balance updated successfully');
    } catch (e) {
      print('Failed to update balance: $e');
    }
  }

  Future<double>getUserBalance (String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        return (userDoc.data()!['balance'] ?? 0.0) as double;
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error fetching balance: $e');
    }
  }
}