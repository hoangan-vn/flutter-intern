import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/src/feature/dashboard/bloc/dashboard_state.dart';
import 'package:safebump/src/router/coordinator.dart';

class DashboardBloc extends Cubit<XNavigationBarItems> {
  DashboardBloc(super.current);

  void onDestinationSelected(int index) {
    emit(XNavigationBarItems.values[index]);
    AppCoordinator.goNamed(state.route.name);
  }

  void goHome() {
    emit(XNavigationBarItems.home);
    AppCoordinator.goNamed(state.route.name);
  }
}
