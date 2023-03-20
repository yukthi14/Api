abstract class InterfaceState{
}
class InitialState extends InterfaceState{
  InitialState();
}
class DisplayState extends InterfaceState{
  List allData;
  DisplayState({required this.allData});
}
class SearchState extends InterfaceState{
  List allData;
  SearchState({required this.allData});
}
class SearchErrorState extends InterfaceState{
  String error;
  SearchErrorState({required this.error});
}
class ErrorMessage extends InterfaceState{
  String msg;
  ErrorMessage({required this.msg});
}