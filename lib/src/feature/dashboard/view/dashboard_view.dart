import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/src/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:safebump/src/feature/dashboard/bloc/dashboard_state.dart';
import 'package:safebump/src/feature/dashboard/widget/navigation_bar.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    super.key,
    required this.currentItem,
    required this.body,
  });

  final XNavigationBarItems currentItem;
  final Widget body;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(widget.currentItem),
      child: BlocBuilder<DashboardBloc, XNavigationBarItems>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              context.read<DashboardBloc>().goHome();
            },
            child: Scaffold(
              body: widget.body,
              bottomNavigationBar: const XBottomNavigationBar(),
            ),
          );
        },
      ),
    );
  }
}
