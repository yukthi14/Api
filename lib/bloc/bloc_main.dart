import 'dart:convert';
import 'package:api/bloc/bloc_event.dart';
import 'package:api/bloc/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../constants/strings.dart';
import '../model_repo.dart';

class ApiPass extends Bloc<InterfaceEvent, InterfaceState>{
  ApiPass(): super(InitialState()) {
    List<Row> rowData = [];

    on<GetDataEvent>((event, emit) async {
      try {
        Response response = await http.get(Uri.http(Strings.uri, Strings.path));
        Welcome data = Welcome.fromJson(jsonDecode(response.body));
        rowData.addAll(data.rows);
        if (response.statusCode == 200) {
          print(data);
        }
        emit(DisplayState(allData: rowData));
      }
      catch (e) {
        emit(ErrorMessage(msg: Strings.errorMessage));
      }
    });
    on<SearchEvent>((event, emit) async {
        if (event.value.isEmpty) {
          emit(DisplayState(allData: rowData));
        }
        List<Row> result=rowData.where((element) => element.title?.toLowerCase().contains(event.value.toLowerCase())==true).toList();
        if(result.isNotEmpty){
          emit(SearchState(allData:result));
        }
        else{
          emit(SearchErrorState(error:"Search not found !!!"));
        }
    });
  }
}