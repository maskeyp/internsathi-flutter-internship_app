// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:internship_app/util/buttons.dart';
import 'package:internship_app/util/colors.dart';

class ItemDialog extends StatelessWidget {
  dynamic itemcontroller;
  VoidCallback onSave;
  VoidCallback onCancel;

  ItemDialog({
    super.key,
    required this.itemcontroller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.fancyWhite,
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            // get user input
            TextField(
              maxLines: 6,
              controller: itemcontroller,
              decoration: const InputDecoration(
                hintText: "Add New Item",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),

            // buttons --> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //save button
                Buttons(
                  text: "Save",
                  onPressed: onSave,
                  color: Colors.deepPurple,
                ),

                Buttons(
                    text: "Cancel",
                    onPressed: onCancel,
                    color: Colors.redAccent),
                //cancel button
              ],
            )
          ],
        ),
      ),
    );
  }
}
