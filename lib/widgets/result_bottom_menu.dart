import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/problem_hint_popup.dart';

class Result_Bottom_Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          SizedBox( // top margin
            height: 20,
          ),
          Container(
            // color: Colors.black,
            padding: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
            child: Row( // Bottom Navigation Bar
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextButton( // Hint Button
                      onPressed: () {
                        hint_dialog(context);
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('icon/solution.png'),
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '문제해설',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff2355DA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
                        // 상화좌우 padding 5px
                      ),
                    ), // end of Hint Button
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () {

                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('icon/next.png'),
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '메모',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff2355DA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
                        // 상화좌우 padding 5px
                      ),
                    ),
                  ),
                ),
              ],
            ), // end of Bottom Navigation Bar,
          ),
        ],
      ),
    );
  }
}