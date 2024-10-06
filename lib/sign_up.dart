import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_cow_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coding_cow_app/data_account.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  String _errorMessage = '';

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await _firestore.collection('users').doc(_emailController.text.trim()).set({
        'email': _emailController.text.trim(),
        'createdAt': Timestamp.now(),
        'lastLoginAt': Timestamp.now(),
        'isAttend':false,
        'level': 1,
        'problemsSolved': 0,
        'languageSetting': 2,
        'bracketSetting': 1,
        'attendanceDays': 1,
        'restEXP': 10,
        'nickname': _nicknameController.text.trim(),
      });
      await handleDailyAttendance(_emailController.text.trim());

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Main_Page()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
        case 'email-already-in-use':
        _errorMessage = '이미 사용중인 이메일입니다.';
        break;
        case 'invalid-email':
        _errorMessage = '잘못된 이메일 형식입니다.';
        break;
        case 'weak-password':
        _errorMessage = '비밀번호가 너무 약합니다.';
        break;
        default:
        _errorMessage = '회원 가입 중 오류가 발생했습니다. 다시 시도해주세요.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 350,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 350,
                child: TextField(
                  controller: _nicknameController,
                  decoration: InputDecoration(
                    hintText: 'Nickname',
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 350,
                child: ElevatedButton(
                  onPressed: _signUpWithEmailAndPassword,
                  child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff2355DA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}