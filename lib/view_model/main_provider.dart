import 'dart:convert';
import 'dart:io';

import 'package:api/api_responce.dart';
import 'package:flutter/cupertino.dart';

import '../model/currency.dart';
import 'package:http/http.dart' as http;

class MainProvider extends ChangeNotifier{
  List<CurrencyRate> _currencyList = [];

  ApiResponse _apiResponse = ApiResponse.initial("message");

  ApiResponse getResponse () {
    return _apiResponse;
  }

  List<CurrencyRate> currencies() {
    return _currencyList;
  }


  Future<ApiResponse> getCurrency() async{
    String url = "https://nbu.uz/uz/exchange-rates/json/";
    Uri myUri = Uri.parse(url);
    try{
      var response = await http.get(myUri);
      List<dynamic> data = jsonDecode(response.body);

      _currencyList.clear();

      data.forEach((element) {
        _currencyList.add(CurrencyRate.fromJson(element));
      });

      _apiResponse = ApiResponse.success(_currencyList);

    }catch(e) {
      if(e is SocketException) {
        return _apiResponse = ApiResponse.error("Check the network");
      }else{
        return _apiResponse = ApiResponse.error(e.toString());
      }
    }

    return _apiResponse;
  }

}