import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List zamlist = [];

  @override
  void initState() {
    super.initState();

    zamlist.addAll(['артур', 'не артур', 'куда же без крепления']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Заметки',
            style: TextStyle(color: Colors.orange[700]),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: zamlist.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(zamlist[index]),
                child: Card(
                  color: Colors.grey[800],
                  child: ListTile(
                    title: Text(
                      zamlist[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ));
          },
        ));
  }
}
