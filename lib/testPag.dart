import 'dart:async';

import 'package:flutter/material.dart';


class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  List<String> data  = [];
  List<String> onlinedatdata  = [

  ];
  StreamController<List<String>> _streamController = StreamController();

   get_date ()
  {
    List<String> _data = List.generate(15, (index) =>"Item ${index}");
    _streamController.add(_data);
  }
  
  Future<void> updaet() async
  {
    await Future.delayed(Duration(seconds: 15));
    data = onlinedatdata;
    _streamController.add(data);
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_date();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
         onPressed: updaet,
      ),

      appBar: AppBar(
        title: Text("Test page"),
      ),


      //body
      body: StreamBuilder<List<String>>(
        stream: _streamController.stream,
        builder: (context,snap){
          if(snap.connectionState ==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }
          if(snap.data ==null)
            {
              return Text("Null");
            }


          return Center(child: ListView(
            children: [
              Text(onlinedatdata.toString()),
              for(String i in snap.data!)
                ListTile(
                  title: Text(i),
                  trailing:IconButton(
                    onPressed: (){
                      snap.data!.remove(i);
                      setState(() {});

                      updaet();
                    },
                    icon: Icon(Icons.delete),
                  ),
                )

            ]
          ),);
        },
      ),


    );
  }
}
