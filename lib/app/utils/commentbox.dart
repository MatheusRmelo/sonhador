import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/fonts.dart';

class CommentBox extends StatelessWidget {
  CommentBox(
      {@required this.userId,
      @required this.comment,
      @required this.liked,
      @required this.handleClickLiked,
      @required this.index,
      @required this.commentsNumber});

  final String userId;
  final String comment;
  final bool liked;
  final Function handleClickLiked;
  final int index;
  final String commentsNumber;

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
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
              icon: Column(
                children: [
                  Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                    color: liked ? Colors.red : Colors.black,
                  ),
                  Text(
                    commentsNumber,
                    style: smallStyle,
                  )
                ],
              ),
              onPressed: () {
                handleClickLiked(index);
              }),
        ],
      ),
    );
  }
}
