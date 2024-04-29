import 'package:flutter/material.dart';

void hint_dialog(context) { // setting popup
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffeafceb),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "* 짝수와 홀수의 정의에 대해서 생각해봅시다",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: -3,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: '어떤 수를 짝수라고 하고, 어떤 수를 홀수라고 할까요? 짝수는 ',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: -2,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '2의 배수',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: -2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1f8e22),
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '이기도 합니다. 어떻게 하면 if문에서 2의 배수를 찾아낼 수 있을까요? ',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '어떤 ',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '산술 연산자',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: -2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1f8e22),
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '를 사용할지 고민해봅시다',
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff1f8e22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.all(10),
                    // 상화좌우 padding 5px
                  ),
                  child: Text(
                    '닫기',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
} // end of setting popup