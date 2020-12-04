import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:velocity_x/velocity_x.dart';

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[350],
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                ),
                Container(
                  height: 28,
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  alignment: Alignment.topCenter,
                  child: "FRUTA FRESCA".text.white.make(),
                ).pOnly(bottom: 10)
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.091,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (_, i) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: "Product $i".text.center.black.make().p(4),
                  ).p(7);
                },
              ),
            ),
            Container(
              color: kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "117 Items".text.white.bold.size(18).make(),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD456),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Filter".text.make(),
                        Image.asset('assets/images/filter-bg.png')
                      ],
                    ).pOnly(left: 5, right: 2),
                  )
                ],
              ).pOnly(top: 10, bottom: 10, right: 20, left: 20),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int i) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/veg$i.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ).p(20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            "Fresh & go $i".text.size(8).make(),
                            "Regulador de platano $i".text.bold.make(),
                            DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: _selectedItem,
                                    items: _dropdownMenuItems,
                                    onChanged: (value) {
                                      setState(() {
                                        // _selectedItem = value;
                                      });
                                    })),
                            Row(
                              children: [
                                "\$: $i".text.xl.make(),
                                Expanded(child: SizedBox()),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: "ADD".text.white.size(10).make().p(8),
                                ).pOnly(right: 10),
                                Container(
                                  alignment: Alignment.center,
                                  color: Color(0xFFFFD456),
                                  child: VxStepper(
                                    inputBoxColor: Colors.grey[350],
                                    actionButtonColor: Colors.transparent,
                                    onChange: (v) {
                                      print(v);
                                    },
                                  ).pOnly(left: 5, right: 5),
                                )
                              ],
                            )
                          ],
                          // ),
                        ),
                      ).pOnly(top: 30)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
