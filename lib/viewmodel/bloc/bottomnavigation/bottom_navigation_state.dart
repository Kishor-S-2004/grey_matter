part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationState {
  final int currentIndex;
  const BottomNavigationState(this.currentIndex);
}

final class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial(super.currentIndex);
}
