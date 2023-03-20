abstract class InterfaceEvent{

}
class GetDataEvent extends InterfaceEvent{
  GetDataEvent();
}
class DisplayEvent extends InterfaceEvent{
  DisplayEvent();
}
class SearchEvent extends InterfaceEvent{
  String value;
  SearchEvent({required this.value});
}
class SearchErrorEvent extends InterfaceEvent{
  SearchErrorEvent();
}