import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api_responce.dart';
import '../view_model/main_provider.dart';

class Calculate extends StatefulWidget {
  const Calculate({super.key});

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {

  late MainProvider _mainProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainProvider = Provider.of<MainProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    final _controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title: const Text("Calculate Currency"),backgroundColor: Colors.green.shade600,),
      body: Column(
        children: [
               Padding(
                padding: EdgeInsets.only(left: width * 0.1,right: width * 0.1,top: height * 0.1),
                child:  Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    width: width * 0.8 ,height: height * 0.4,
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: const Text('Select Currency'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return FutureBuilder(
                                  future: _mainProvider.getCurrency(),
                                  builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
                                    if(snapshot.data?.status == Status.SUCCESS ) {

                                      return ListView.builder(
                                        itemCount: 5,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Text(snapshot.data?.data[index].title);
                                        },
                                      );
                                    }
                                    return Container();
                                  },
                                );
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 60,left: 60),
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
