import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ResultTile extends StatelessWidget {

  final Widget? leading;
  final Widget? trailing;
  const ResultTile({super.key , this.leading , this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 4,color: Colors.grey[100]!.withOpacity(0.25)))
      ),
      padding: const EdgeInsets.all(35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: TextStyle(fontFamily: GoogleFonts.kanit().fontFamily , color: Colors.black , fontWeight: FontWeight.w800 ,letterSpacing: 1.25),
            child: leading ?? Container()),
          Spacer(),
          trailing ?? Container()
        ],
      ),
    );
  }
}