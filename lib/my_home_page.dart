import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ebook_app/app_color.dart' as appcolors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<dynamic> popularBooks = [];
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: appcolors.backgroud,
        child: SafeArea(
            child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(AssetImage("img/menu.png"),
                        size: 24, color: Colors.black),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Popular Books',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -30,
                      right: 0,
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount:
                                popularBooks == null ? 0 : popularBooks.length,
                            itemBuilder: (_, i) {
                              return Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(popularBooks[i]["img"]),
                                      fit: BoxFit.fill,
                                    )),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            child: TabBar(
                                indicatorPadding: const EdgeInsets.all(0),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelPadding: const EdgeInsets.all(0),
                                controller: _tabController,
                                isScrollable: true,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                                tabs: [
                                  Container(
                                    width: 120,
                                    height: 58,
                                    child: Text(
                                      "New",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 7,
                                            offset: Offset(0, 0),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 58,
                                    child: Text(
                                      "New",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 7,
                                            offset: Offset(0, 0),
                                          )
                                        ]),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 58,
                                    child: Text(
                                      "New",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 7,
                                            offset: Offset(0, 0),
                                          )
                                        ]),
                                  ),
                                ]),
                          )),
                    )
                  ];
                },
                body: TabBarView(controller: _tabController, children: [
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  ),
                ]),
              ))
            ],
          ),
        )));
  }
}
