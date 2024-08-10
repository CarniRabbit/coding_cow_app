/*
 * 딩카 로그인화면
 */

import 'package:coding_cow_app/main.dart';
import 'package:flutter/material.dart';

class Login_Page extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  child: Image.asset(
                    'character/codingcow.png',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width:350,
                child: TextField( // Email input
                  decoration: InputDecoration(
                    hintText: 'Email',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff2355DA)
                      ),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                keyboardType: TextInputType.emailAddress,
                ), // end of Email input
              ),
              SizedBox( // margin-bottom: 16px
                height: 20,
              ),
              Container(
                width: 350,
                child: TextField( // Password input
                  decoration: InputDecoration(
                    hintText: 'Password',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff2355DA),
                      ),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                obscureText: true,
                ), // end of Password input
              ),
              SizedBox( // margin-bottom: 20px
                height: 20,
              ),
              Container(
                width: 350,
                height: 50,
                child: ElevatedButton( // Login button (submit)
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Main_Page()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff2355DA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ), // end of Login button
              ),
              SizedBox( // margin-bottom: 20px
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton( // Sign up Button
                      onPressed: (){
                        //회원가입 logic
                      },
                      child: Text('Sign Up'),
                  ), // end of Sign up Button
                  SizedBox( // margin-right: 110px
                    width: 110,
                  ),
                  TextButton( // Find Password Button
                    onPressed: (){
                      //비밀번호 찾기 logic
                    },
                    child: Text(
                      'Forgot password?',
                    ),
                  ), // end of Find Password Button
                ],
              ),
            ],
        ),
      ),
    );
  }
}