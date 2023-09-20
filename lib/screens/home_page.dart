import 'package:api/api_responce.dart';
import 'package:api/screens/calculate.dart';
import 'package:api/screens/no_internet.dart';
import 'package:api/view_model/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  late MainProvider _mainProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainProvider = Provider.of<MainProvider>(context,listen: false);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if(value == 1) Navigator.push(context, MaterialPageRoute(builder: (context) => const Calculate()));
        },
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: Colors.grey.shade400, // <-- This works for fixed
        selectedItemColor: Colors.green.shade600,
        unselectedItemColor: Colors.grey.shade700,
        items: const [
           BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculate',
          ),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child:  AppBar(
         // centerTitle: true,
          title: const Text("Valyuta kurslari",style: TextStyle(fontSize: 22),),
          actions: [
            iconRefresh(),
          ],
          backgroundColor: Colors.green.shade600,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          Future<void>.delayed(const Duration(seconds: 2));
          setState(() {
           _mainProvider.getCurrency;
          });
        },
        child: FutureBuilder(
            future: _mainProvider.getCurrency(),
            builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
              if(snapshot.data?.status == Status.LOADING ) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.data?.status == Status.SUCCESS ) {
                return ListView.builder(
                    itemCount:  snapshot.data?.data.length ?? 0,
                    itemBuilder: (BuildContext context,   int index) {
                      if(snapshot.data?.data[index].cell_price!.length == 0 ||
                          snapshot.data?.data[index].buy_price!.length == 0) {
                        snapshot.data?.data[index].cell_price = "No info";
                        snapshot.data?.data[index].buy_price = "No info";
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              height: 160,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 20,right: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(flagMetod(index),width:40 , height: 30,),
                                          const SizedBox(width: 12,),
                                          Text(snapshot.data?.data[index].code ?? "",
                                            style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500),
                                          ),
                                       //   const SizedBox(width: 200,),
                                        ],
                                      ),
                                      const SizedBox(height: 30,),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("MB kursi"),
                                          Text("Sotib olish"),
                                          Text("Sotish"),
                                        ],
                                      ),
                                      const SizedBox(height: 12,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(snapshot.data?.data[index].cb_price ?? "...",
                                                     style: const TextStyle(fontWeight: FontWeight.bold),),
                                          Text(snapshot.data?.data[index].buy_price ?? "...",
                                                     style: const TextStyle(fontWeight: FontWeight.bold),),
                                          Text(snapshot.data?.data[index].cell_price  ?? "...",
                                                     style: const TextStyle(fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
              }
              if(snapshot.data?.status == Status.ERROR ) {
                return NoInternet(snapshot.data?.message);
              }
              return Container();
            },
          ),
      ),
    );
  }



  Widget iconRefresh() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(onPressed: () {
        setState(() {
          _mainProvider.getCurrency();
        });
      },
        icon: const Icon(Icons.refresh,size: 36,),
      ),
    );
  }






  String flagMetod(int index) {

    List<String> flags = [
      "assets/images/baa.png",
      "assets/images/avstr.png",
      "assets/images/kanada.png",
      "assets/images/shvet.png",
      "assets/images/xitoy.png",
      "assets/images/daniya.png",
      "assets/images/misr.png",
      "assets/images/yevro.png",
      "assets/images/anglia.png",
      "assets/images/islan.png",
      "assets/images/yapon.png",
      "assets/images/kores.png",
      "assets/images/quvayt.png",
      "assets/images/qozoq.png",
      "assets/images/livan.png",
      "assets/images/malay.png",
      "assets/images/norve.png",
      "assets/images/polsh.png",
      "assets/images/rus.png",
      "assets/images/rus.png",
     // "assets/images/shvetsiya.png",
      "assets/images/singapur.png",
      "assets/images/turk.png",
      "assets/images/ukrain.png",
      "assets/images/aqsh.png",
    ];

    return flags[index];

  }

}
