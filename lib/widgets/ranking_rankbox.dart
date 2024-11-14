import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUserRankBox extends StatefulWidget {
  @override
  _CurrentUserRankBoxState createState() => _CurrentUserRankBoxState();
}

class _CurrentUserRankBoxState extends State<CurrentUserRankBox> {
  String _currentUserRank = "로딩 중...";

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserRank();
  }

  Future<void> _fetchCurrentUserRank() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      try {
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(currentUser.email).get();
        int currentUserProblemsSolved = userDoc['problemsSolved'] ?? 0;

        // 모든 사용자 중에서 현재 사용자의 순위를 계산
        QuerySnapshot rankingSnapshot = await _firestore
            .collection('users')
            .orderBy('problemsSolved', descending: true)
            .get();

        int rank = 1;
        for (var doc in rankingSnapshot.docs) {
          if (doc['problemsSolved'] == currentUserProblemsSolved) {
            _currentUserRank = "$rank위";
            break;
          }
          rank++;
        }
      } catch (e) {
        print("사용자 순위를 가져오는 중 오류가 발생했습니다: $e");
        _currentUserRank = "순위를 가져올 수 없습니다.";
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 30),
          Image(
            image: AssetImage('character/codingcowcrown.gif'),
            width: 120,
          ),
          SizedBox(width: 50),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "현재",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _currentUserRank,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}