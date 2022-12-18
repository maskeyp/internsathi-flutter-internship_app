import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ItemTile extends StatelessWidget {
  final String itemName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ItemTile({
    super.key,
    required this.itemName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
              //task name
              Flexible(
                flex: 2,
                child: Text(
                  itemName,
                  style: TextStyle(
                      overflow: TextOverflow.clip,
                      color: Colors.white,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
