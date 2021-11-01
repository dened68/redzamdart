import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userToDo = '';
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('нету');
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(snapshot.data!.docs[index].id),
                child: Card(
                  color: Colors.grey[800],
                  child: ListTile(
                    title: Text(
                      snapshot.data!.docs[index].get('item'),
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                        // ignore: prefer_const_constructors
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(snapshot.data!.docs[index].id)
                              .delete();
                        }),
                  ),
                ),
                onDismissed: (direction) {
                  //if(direction == DismissDirection.endToStart )
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        child: Icon(
          Icons.add,
          color: Colors.orange,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                const kOrange = const Color(0xFFffd600);
                return AlertDialog(
                  backgroundColor: Colors.grey[800],
                  title: Text(
                    'Новая заметка',
                    style: TextStyle(color: Colors.orange[700]),
                  ),
                  content: TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.orange))),
                    onChanged: (String value) {
                      userToDo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .add({'item': userToDo});
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Colors.grey[700])),
                        child: Text(
                          'добавить',
                          style: TextStyle(color: Colors.orange[700]),
                        ))
                  ],
                );
              });
        },
      ),
    );
  }
}
