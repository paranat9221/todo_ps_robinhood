import 'package:flutter/material.dart';
import 'package:todo_ps_robinhood/core/res/app_style.dart';
import 'package:todo_ps_robinhood/core/res/app_text.dart';
import 'package:todo_ps_robinhood/core/res/app_value.dart';
import 'package:todo_ps_robinhood/models/todo_task.dart';

class MainAppbar extends StatelessWidget {
  const MainAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: AppPadding.main,
            top: AppPadding.main,
          ),
          child: const CircleAvatar(child: Icon(Icons.person)),
        )
      ],
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      floating: false,
      pinned: true,
      expandedHeight: AppValue.mainHeaderExpanded,
      shadowColor: Colors.black45,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: AppValue.mainHeaderTitleScale,
        title: const _Menu(),
        background: const _HeaderBg(),
      ),
    );
  }
}

class _HeaderBg extends StatelessWidget {
  const _HeaderBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: AppStyle.homeHeaderBg,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.main),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppText.mainHeaderTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white),
              ),
              Text(
                AppText.mainHeaderSubtitle,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white),
              ),
              Text(
                AppText.mainHeaderSubtitle2,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppPadding.main),
      child: SafeArea(
        child: Container(
          decoration: AppStyle.homeMenuCon,
          padding: EdgeInsets.symmetric(vertical: AppPadding.sub),
          child: TabBar(
              labelColor: Colors.white,
              indicator: AppStyle.homeTabbarIndicator,
              dividerColor: Colors.transparent,
              tabs: _tabs()),
        ),
      ),
    );
  }

  List<Tab> _tabs() {
    return TaskStatus.values.map((TaskStatus task) {
      return Tab(child: _MenuButton(title: task.label));
    }).toList();
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({Key? key, required String title})
      : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: Center(child: Text(_title)));
  }
}
