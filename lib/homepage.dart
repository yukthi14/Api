import 'package:api/bloc/bloc_event.dart';
import 'package:api/bloc/bloc_main.dart';
import 'package:api/bloc/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
String value="";
  final ApiPass _bloc = ApiPass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "API",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        backgroundColor: Colors.teal.shade800,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (text){
                _bloc.add(SearchEvent(value: text));
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search by title",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.black87,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: const Center(
                  child: Text("About Canada",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic))),
            ),
          ),
          BlocProvider(
              create: (_) => _bloc,
              child: BlocBuilder<ApiPass, InterfaceState>(
                  builder: (context, state) {
                if (state is InitialState) {
                  return _loadingList(context);
                } else if (state is DisplayState) {
                  return _dataList(context, state.allData);
                } else if (state is SearchState) {
                  return _dataList(context, state.allData);
                } else if(state is SearchErrorState){
                  return _errorMessage(context, state.error);
                }
                else {
                  return _loadingList(context);
                }
              }))
        ],
      ),
    );
  }

  Widget _dataList(BuildContext context, List data) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      data[index].title!,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (data[index].imageHref != null)
                    Image.network(data[index].imageHref),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Text(
                        data[index].description,
                        style: const TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      )),
                  //  Text(display["description"].toString()),
                ],
              ),
            );
          }),
    );
  }

  Widget _loadingList(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _errorMessage(BuildContext context, String msg) {
    return Center(
      child: Text(msg),
    );
  }
}
