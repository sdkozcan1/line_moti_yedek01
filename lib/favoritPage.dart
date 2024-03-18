import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

var box = Hive.box("favoriBox");

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    box = Hive.box("favoriBox");
  }

  void deleteData(int id) {
    box.delete(id - 1);
    print("box length: ${box.length}");
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoriler'),
      ),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, box, _) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final item = box.getAt(index);
                if (item != null) {
                  final text = Text(item["text"] ?? "text");
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListTile(
                        title: text,
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                deleteData(item["id"]);
                                print(
                                    "delete icon tıklandı silinen item id     :${item["id"]}");
                              });
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    child: Text("data"),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
