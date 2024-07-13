import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/src/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:safebump/src/feature/dashboard/bloc/dashboard_state.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';

class XBottomNavigationBar extends StatelessWidget {
  const XBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, XNavigationBarItems>(
      builder: (context, state) {
        return ConvexAppBar(
          curveSize: AppSize.s150,
          curve: Curves.linear,
          style: TabStyle.react,
          height: AppSize.s60,
          color: AppColors.black,
          activeColor: AppColors.primary,
          elevation: 5,
          backgroundColor: AppColors.white,
          items: [
            for (int i = 0; i < XNavigationBarItems.values.length; i++)
              TabItem(
                  icon: state.icon == XNavigationBarItems.values[i].icon
                      ? XNavigationBarItems.values[i].selectedIcon
                      : XNavigationBarItems.values[i].icon)
          ],
          onTap: context.read<DashboardBloc>().onDestinationSelected,
        );
      },
    );
  }
}

class Builder extends DelegateBuilder {
  @override
  Widget build(BuildContext context, int index, bool active) {
    return Text(index.toString());
  }
}
