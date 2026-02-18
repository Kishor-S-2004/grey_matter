part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}

class ChangeTab extends BottomNavigationEvent{
  final int index;
  ChangeTab(this.index);
}
