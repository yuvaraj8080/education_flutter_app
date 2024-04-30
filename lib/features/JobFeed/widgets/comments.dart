import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/personalization/screens/setting.dart';
import 'package:flutter_job_app/profile/sceens/profile_page.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
    super.key,
    required this.commentId,
    required this.commenterId,
    required this.commenterName,
    required this.commentBody,
    required this.commenterImageUrl
  });

  final String commentId;
  final String commenterId;
  final String commenterName;
  final String commentBody;
  final String commenterImageUrl;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}
class _CommentScreenState extends State<CommentScreen> {

  final List<Color> _color = [
    Colors.amber,
    Colors.orange,
    Colors.pink.shade200,
    Colors.brown,
    Colors.cyan,
    Colors.blueAccent,
    Colors.deepPurple,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    _color.shuffle();
    return InkWell(
      onTap:()=> Get.to(()=> ProfileScreen(userId:widget.commenterId)),
      child:Row(
        crossAxisAlignment:CrossAxisAlignment.start,
          mainAxisAlignment:MainAxisAlignment.start,
          children:[

            ///COMMENT CIRCLE AVATAR HARE
            Flexible(
                flex:1,
                child:Container(height:45,width:45,
                  decoration:BoxDecoration(border:Border.all(width:3),
                    color:_color[1],
                    shape:BoxShape.circle,
                    image:DecorationImage(image:NetworkImage(widget.commenterImageUrl),
                      fit:BoxFit.fill,
                    )
                  )
                )),

            /// COMMENTER NAME AND BODY HARE
            const SizedBox(width:15),
            Flexible(
                flex:7,
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text(widget.commenterName,style:Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height:5),
                    Text(widget.commentBody,maxLines:5,style:Theme.of(context).textTheme.bodySmall),
                  ],)
            )
      ])
    );
  }
}
