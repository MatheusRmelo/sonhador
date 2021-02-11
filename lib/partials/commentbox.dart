import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  CommentBox(
      {@required this.userId, @required this.comment, this.liked = false});

  final String userId;
  final String comment;
  final bool liked;

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: widthDevice * 0.7,
                  child: Text.rich(
                    TextSpan(
                        text: userId + ': ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: comment,
                              style: TextStyle(fontWeight: FontWeight.normal))
                        ]),
                  )),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.favorite_border,
                size: 16,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }
}
