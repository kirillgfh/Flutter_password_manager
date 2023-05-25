import 'package:flutter/material.dart';

class MyDesktopBody extends StatelessWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(title: const Center(child: Text("D E S K T O P"))),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                     maxHeight: 500.0,
                     // maxWidth: 1300.0,
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        height: 250,
                        color: Colors.deepPurple[400],
                        child: Center(child: Text("BIG\npassword", style: TextStyle(fontSize: 90, color: Colors.white),)),

                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.deepPurple[300],
                              height: 120,
                              child: Center(child: Text("password $index", style: TextStyle(fontSize: 60, color: Colors.white),)),
                            ),
                          );
                        }))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              color: Colors.deepPurple[300],

            ),
          )
        ],
      ),
    );
  }
}
