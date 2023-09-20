import 'package:api/view_model/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoInternet extends StatelessWidget {
  String? message;
  NoInternet(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider _mainProvider = Provider.of<MainProvider>(context,listen: false);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          SizedBox(height: height / 15,),
          const Icon(Icons.signal_wifi_off,color: Colors.blueGrey,size: 90,),
          SizedBox(height: height / 40,),
          const Text("Offline",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          SizedBox(height: height / 20,),
          Text(message ?? "initial",
            style: const TextStyle(fontSize: 22),),
          SizedBox(height: height * 0.4,),
          InkWell(
            onTap: () {
                _mainProvider.getCurrency();
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blueGrey),
              width: width / 1.1, height: height/ 15,
              child: const Center(child: Text("Takrorlash",style: TextStyle(fontSize: 18,color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}
