import 'package:flutter/material.dart';

class Main_TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container ( // top bar
      color: Color(0xff2355DA),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Container(
          alignment: Alignment.topRight, // X박스 align right
          child: SizedBox( // X박스
            width: 50,
            height: 50,
            child: TextButton(
              onPressed: () {

              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xffCD4F2C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                padding: EdgeInsets.all(5),
              ),
              child: Container(
                color: Color(0xffD27F69),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ), // end of X box,
      ),
    ); // end of topbar
  }
}