import '../../../utility/app_colors.dart';
import 'package:flutter/material.dart';
class AddTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  const AddTextButton({
    Key? key, required this.text, required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.add_circle_outlined, color: AppColors.mainColor,),
            SizedBox(width: 5,),
            Text(text,
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
