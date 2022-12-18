import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internship_app/providers/time_provider.dart';
import 'package:internship_app/util/colors.dart';
import 'package:internship_app/util/cutom_drawer.dart';
import 'package:internship_app/util/item_list_tile.dart';
import 'package:provider/provider.dart';

import 'data/item_database.dart';
import 'util/item_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _itemsBox = Hive.box('itemsBox');
  ItemsDatabase db = ItemsDatabase();

  @override
  void initState() {
    //create default data
    if (_itemsBox.get("ITEMSLIST") == null) {
      db.createInitialData();
    } else {
      //data already exist
      db.loadData();
    }
    super.initState();
  }

  // Text Controller
  final _controller = TextEditingController();

  // Checkbox is tapped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.itemsList[index][1] = !db.itemsList[index][1];
    });
    db.updateDataBase();
  }

  // Save new item
  void saveNewItem() {
    setState(() {
      db.itemsList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create new Task
  void createNewItem() {
    showDialog(
      context: context,
      builder: (context) {
        return ItemDialog(
          itemcontroller: _controller,
          onSave: saveNewItem,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete Task
  void deleteTask(int index) {
    setState(() {
      db.itemsList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      backgroundColor: themeModel.appcolor == AppColor.fancyWhite
          ? AppColor.fancyWhite
          : AppColor.fancyDark,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.fancyDark,
        onPressed: createNewItem,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar.large(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomDrawer()),
                  );
                },
                icon: Icon(
                  Icons.menu,
                  color: themeModel.appcolor == AppColor.fancyWhite
                      ? AppColor.fancyWhite
                      : AppColor.fancyDark,
                ),
              ),
              backgroundColor: themeModel.appcolor == AppColor.fancyWhite
                  ? AppColor.fancyDark
                  : AppColor.fancyWhite,
              title: Text(
                themeModel.greeting,
                style: GoogleFonts.raleway(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: themeModel.appcolor == AppColor.fancyWhite
                      ? AppColor.fancyWhite
                      : AppColor.fancyDark,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.more_vert,
                      color: themeModel.appcolor == AppColor.fancyWhite
                          ? AppColor.fancyWhite
                          : AppColor.fancyDark),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thankyou'),
                          content: const Text('For this Opportunity'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text('Done'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ]),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ItemTile(
                itemName: db.itemsList[index][0],
                taskCompleted: db.itemsList[index][1],
                onChanged: (value) => checkboxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            }, childCount: db.itemsList.length),
          ),
        ],
      ),
    );
  }
}
