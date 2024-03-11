import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class TstPage extends StatefulWidget {
  const TstPage({super.key});

  @override
  State<TstPage> createState() => _TstPageState();
}

class _TstPageState extends State<TstPage> {


  StreamController _controller = StreamController();
  StreamController _controller1 = StreamController();
  StreamController _controller2 = StreamController();

  List <String> p = [];

  List<String> fLis  =  List.generate(5, (index) => "follwer ${index}");
  List<String> ufLis  =  List.generate(5, (index) => "unfollwer ${index}");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  void update()
  {
    // int _p = p.length;
    // _p++;
    // p.add("Item Num ${_p}");
    // _controller.add(p);
    _controller1.add(fLis);
    _controller2.add(ufLis);

  }

  void make_follow(int i)
  {
    ufLis.add(fLis[i]);
    fLis.removeAt(i);
    setState(() {

    });
  }

  void make_unfollow(int i)
  {
    fLis.add(ufLis[i]);
    ufLis.removeAt(i);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: (){
        update();
      },),

      appBar: AppBar(
        title:Text("Test Page"+fLis.length.toString()),
      ),

      body:ListView(
        children: [
          StreamBuilder(

            stream: _controller1.stream,

            builder: (context,snap){
              if(snap.connectionState==ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator(),);
                }

              List<String> fdata = snap.data;
              return Column(
                children: [
                  Text("Followers"),
                  for(String d in fdata)
                    ListTile(
                      title: Text(d),
                      trailing:  TextButton(
                        child: Text("Follower"),
                        onPressed: (){
                          make_unfollow(0);
                        },
                      ),
                    ),
                ],
              );

            },
          ),
          StreamBuilder(

            stream: _controller2.stream,

            builder: (context,snap){
              if(snap.connectionState==ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator(),);
              }

              List<String> fdata = snap.data;
              return Column(
                children: [
                  Text("unfollowers"),
                  for(String d in fdata)
                    ListTile(
                      title: Text(d),
                      trailing: TextButton(
                        child: Text("Follow"),
                        onPressed: (){
                          make_follow(0);
                        },
                      ),
                    ),
                ],
              );

            },
          ),
        ],
      ),




    );
  }
}
