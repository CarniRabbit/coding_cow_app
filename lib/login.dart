/*
 * 딩카 로그인화면
 */

import 'package:coding_cow_app/main.dart';
import 'package:coding_cow_app/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data_global.dart';

class Login_Page extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login_Page> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';
  Future<void> _signInwithEmailAndPassword() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // await handleDailyAttendance(auth.currentUser?.email);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Main_Page()),
      );
    } on FirebaseAuthException catch (e) {
      //print('Error code: ${e.code}');
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = '해당 이메일로 가입된 사용자를 찾을 수 없습니다.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = '이메일 또는 비밀번호가 틀렸습니다.';
        } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          _errorMessage = '이메일 또는 비밀번호가 틀렸습니다.';
        } else if (e.code == 'invalid-email') {
          _errorMessage = '잘못된 이메일 형식입니다.';
        } else {
          _errorMessage = '로그인 중 오류가 발생했습니다. 다시 시도해주세요.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = '알 수 없는 오류가 발생했습니다. 다시 시도해주세요.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.4,
                child: Image.asset(
                  'character/codingcow.png',
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 350,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff2355DA)),
                  ),
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
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff2355DA)),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Container(
                width: 350,
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 20),
            Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: _signInwithEmailAndPassword,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xff2355DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
                SizedBox(width: 110),
                TextButton(
                  onPressed: () {
                    // 비밀번호 찾기 logic
                  },
                  child: Text('Forgot password?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}