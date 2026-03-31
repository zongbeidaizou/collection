import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/res/dimens.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/device_utils.dart';
import 'package:bounty_hunter/util/other_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:bounty_hunter/models/help_entity.dart';
import 'package:bounty_hunter/net/net.dart';
import 'dart:async';
import 'package:flutter/material.dart';
const Map<String, Icon> icons = {
  'case_item_source_system': Icon(Icons.miscellaneous_services,color: Colors.blue,),
  'case_item_source_admin': Icon(Icons.loupe,color: Colors.red,),
  'case_item_source_retain': Icon(Icons.repeat_one,color: Colors.green,),
  'case_item_source_receive': Icon(Icons.move_up,color: Colors.purple,),
  'case_item_discount': Icon(Icons.discount,color: Colors.green,),
  'case_item_coupon_chance': Icon(Icons.auto_fix_normal,color: Colors.orange,),
  'case_item_coupon_count': Icon(Icons.confirmation_number_rounded,color: Colors.green,),
  'case_item_extention_count': Icon(Icons.extension_outlined,color: Color.fromARGB(255, 128, 188, 225),),
  'case_item_transfer': Icon(Icons.transfer_within_a_station,color: Colors.red,),
  'case_item_last_login': Icon(Icons.login,color: Colors.blue,),
  'marketing_uninterested': Icon(Icons.sentiment_dissatisfied_outlined,color: Colors.red,),
  'marketing_unknown': Icon(Icons.sentiment_neutral_rounded,color: Colors.orange,),
  'marketing_interested': Icon(Icons.sentiment_satisfied_sharp,color: Colors.green,),
  'unable_to_contact': Icon(Icons.close,color: Colors.red,),
  'no_response': Icon(Icons.access_time_outlined,color: Colors.grey,),
  'responded': Icon(Icons.done_all,color: Colors.green,),
  'log_sync': Icon(Icons.sync,color: Colors.grey,),
  'log_ptp': Icon(Icons.more_time,color: Colors.green,),
  'log_bp': Icon(Icons.hourglass_disabled,color: Colors.orange,),
  'log_no_answer': Icon(Icons.phone_disabled,color: Colors.red,),
  'log_part': Icon(Icons.nightlight,color: Color.fromARGB(255, 137, 139, 141),),
  'log_settled': Icon(Icons.lens,color: Colors.green,),
  'log_extend': Icon(Icons.extension_outlined,color: Color.fromARGB(255, 128, 188, 225),),
  'log_retain': Icon(Icons.repeat_one,color: Colors.green,),
  'log_receive': Icon(Icons.move_up,color: Colors.purple,),
  'log_admin': Icon(Icons.loupe,color: Colors.red,),
  'log_transfer_out': Icon(Icons.delete_forever_outlined,color: Colors.orange,),
  'bonus_money_off_csred_outlined': Icon(Icons.money_off_csred_outlined,color: Color.fromARGB(255, 65, 83, 0),),
  'bonus_lens': Icon(Icons.lens,color: Colors.green,),
  'bonus_my_location': Icon(Icons.my_location,color: Colors.purpleAccent,),
  'bonus_nightlight': Icon(Icons.nightlight,color: Color.fromARGB(255, 137, 139, 141),),
  'bonus_bar_chart_rounded': Icon(Icons.bar_chart_rounded,color: Color.fromARGB(218, 218, 125, 4),),
  'bonus_golf_course': Icon(Icons.golf_course,color: Color.fromARGB(255, 244, 0, 159),),
  'bonus_transfer_within_a_station': Icon(Icons.transfer_within_a_station,color: Colors.red,),
  'bonus_extension_outlined': Icon(Icons.extension_outlined,color: Color.fromARGB(255, 128, 188, 225),),
  'bonus_person_outline_outlined': Icon(Icons.person_outline_outlined,color: Color.fromARGB(255, 244, 234, 52),),
  'bonus_how_to_reg_outlined': Icon(Icons.how_to_reg_outlined,color: Color.fromARGB(255, 187, 230, 118),),
  'bonus_build_outlined': Icon(Icons.build_outlined,color: Color.fromARGB(255, 180, 182, 177),),
};
const Map<String, BoxFit> fit = {
  'width': BoxFit.fitWidth,
  'height': BoxFit.fitHeight,
  'fill': BoxFit.fill,
  'cover': BoxFit.cover,
  'contain': BoxFit.contain,
};
class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  static Future<HelpEntity?>? _helpFuture;

  static Future<HelpEntity?> _fetchHelp() async {
    final Completer<HelpEntity?> completer = Completer<HelpEntity?>();
    try {
      await DioUtils.instance.requestNetwork<HelpEntity>(
        Method.get,
        HttpApi.helps,
        onSuccess: (data) {
          if (!completer.isCompleted) {
            completer.complete(data);
          }
        },
        onError: (_, __) {
          if (!completer.isCompleted) {
            completer.complete(null);
          }
        },
      );
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    } catch (_) {
      if (!completer.isCompleted) {
        completer.complete(null);
      }
    }
    return completer.future;
  }


  @override
  Widget build(BuildContext context) {

    final Color? iconColor = ThemeUtils.getIconColor(context);
    final bool isDark = context.isDark;
    void _launchWebURL(String title, String url) {
      if (Device.isMobile) {
        NavigatorUtils.goWebViewPage(context, title, url);
      } else {
        Utils.launchWebURL(url);
      }
    }

    final Future<HelpEntity?> future = _helpFuture ??= _fetchHelp();
    return FutureBuilder<HelpEntity?>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<HelpEntity?> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                tooltip: 'Back',
                onPressed: () => NavigatorUtils.goBack(context),
                icon: Icon(Icons.arrow_back,
                    color: iconColor ?? Colors.white),
              ),
              centerTitle: true,
              title: Text(
                'Help Center',
                style: TextStyle(color: ThemeUtils.getIconColor(context)),
              ),
              flexibleSpace: isDark
                  ? Container(
                      height: 115.0,
                      color: Colours.dark_bg_color,
                    )
                  : LoadAssetImage(
                      'statistic/statistic_bg',
                      height: 115.0,
                      fit: BoxFit.fitWidth,
                    ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _launchWebURL(
                        'Help Center',
                        snapshot.data?.other?.h5?? '');
                  },
                  icon: const Icon(Icons.question_mark_outlined,
                      color: Colors.white),
                ),
              ],
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final HelpEntity? help = snapshot.data;
        final List<HelpData> tabsData = (help?.data ?? [])
            .where((e) => (e.tab ?? '').trim().isNotEmpty)
            .toList();

        if (tabsData.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                tooltip: 'Back',
                onPressed: () => NavigatorUtils.goBack(context),
                icon: Icon(Icons.arrow_back,
                    color: iconColor ?? Colors.white),
              ),
              centerTitle: true,
              title: Text(
                'Help Center',
                style: TextStyle(color: ThemeUtils.getIconColor(context)),
              ),
              flexibleSpace: isDark
                  ? Container(
                      height: 115.0,
                      color: Colours.dark_bg_color,
                    )
                  : LoadAssetImage(
                      'statistic/statistic_bg',
                      height: 115.0,
                      fit: BoxFit.fill,
                    ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _launchWebURL(
                        'Help Center',
                        snapshot.data?.other?.h5?? '');
                  },
                  icon: const Icon(Icons.question_mark_outlined,
                      color: Colors.white),
                ),
              ],
            ),
            body: const Center(
              child: Text('No help data'),
            ),
          );
        }

        final List<Tab> tabs = tabsData
            .map((e) => Tab(text: (e.tab ?? '').trim()))
            .toList();

        return DefaultTabController(
          length: tabsData.length,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                tooltip: 'Back',
                onPressed: () => NavigatorUtils.goBack(context),
                icon: Icon(Icons.arrow_back, color: iconColor ?? Colors.white),
              ),
              centerTitle: true,
              title: Text(
                'Help Center',
                style: TextStyle(color: ThemeUtils.getIconColor(context)),
              ),
              flexibleSpace: isDark
                  ? Container(
                      height: 115.0,
                      color: Colours.dark_bg_color,
                    )
                  : LoadAssetImage(
                      'statistic/statistic_bg',
                      height: 115.0,
                      fit: BoxFit.fill,
                    ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _launchWebURL(
                        'Help Center',
                        snapshot.data?.other?.h5?? '');
                  },
                  icon: const Icon(Icons.question_mark_outlined,
                      color: Colors.white),
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                labelColor: Colours.app_main,
                unselectedLabelColor: Colours.text_gray,
                indicatorColor: Colours.app_main,
                tabs: tabs,
              ),
            ),
            body: TabBarView(
              children: tabsData.map((tab) {
                final List<HelpDataItems> items = tab.items ?? <HelpDataItems>[];
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: items
                      .map((it) => _StepSectionCard(
                            entity: _toStepEntity(it),
                          ))
                      .toList(),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}



class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text(
            //   title,
            //   style: Theme.of(context)
            //                       .textTheme
            //                       .titleLarge
            //                       ?.copyWith(fontSize: Dimens.font_sp16, fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _ScreenshotImage extends StatelessWidget {
  const _ScreenshotImage({
    required this.asset,
    required this.hint,
    this.fit = BoxFit.fitWidth,
  });

  final String asset;
  final String hint;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 12 / 9,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueGrey.withOpacity(0.25)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GestureDetector(
              onTap: () => _openPreview(context),
              child: LoadAssetImage(
                asset,
                fit: fit,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (hint.isNotEmpty) Text(
          hint,
            style: Theme.of(context)
                                    .textTheme
                                    .bodySmall?.copyWith(color: Colors.red),
        ),
      ],
    );
  }

  void _openPreview(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (BuildContext dialogCtx) {
        return GestureDetector(
          onTap: () => Navigator.of(dialogCtx).pop(),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 5.0,
              child: LoadAssetImage(
                asset,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ManualStep extends StatelessWidget {
  const _ManualStep({
    required this.no,
    required this.title,
    required this.description,
    required this.icons,
  });

  final int no;
  final String title;
  final String description;
  final List<_IconExplain> icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color.fromARGB(255, 247, 179, 8),
                child: Text(
                  '$no',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                                  .textTheme
                                  .titleLarge?.copyWith(fontSize: Dimens.font_sp18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          if (description.isNotEmpty) Padding(padding: const EdgeInsets.only(left: 32), child: Text(description,style: TextStyle(fontSize: Dimens.font_sp12),)),
          if (icons.isNotEmpty) ...<Widget>[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: icons,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IconExplain extends StatelessWidget {
  const _IconExplain({
    required this.icon,
    required this.text,
  });

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: <Widget>[
          SizedBox(width: 22, child: Center(child: icon)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: Theme.of(context)
                                  .textTheme
                                  .titleLarge?.copyWith(fontSize: Dimens.font_sp12))),
        ],
      ),
    );
  }
}



/// Data models the user asked for:
/// stepEntity: title, image, instruction, steps[]
/// steps[]: no, title, description, icons[]
/// icons[]: icon, text
class _StepIcon {
  const _StepIcon({required this.icon, required this.text});
  final Widget icon;
  final String text;
}

class _StepItem {
  const _StepItem({
    required this.no,
    required this.title,
    this.description,
    this.icons,
  });
  final int no;
  final String title;
  final String? description;
  final List<_StepIcon>? icons;
}

class _StepEntity {
  const _StepEntity({
    required this.title,
    required this.image,
    required this.instruction,
    required this.steps,
    this.fit = BoxFit.fitWidth,
  });
  final String title;
  final String image;
  final String instruction;
  final List<_StepItem> steps;
  final BoxFit fit;
}

class _StepSectionCard extends StatelessWidget {
  const _StepSectionCard({required this.entity});
  final _StepEntity entity;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: entity.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ScreenshotImage(asset: entity.image, hint: entity.instruction, fit: entity.fit),
          const SizedBox(height: 8),
          ...entity.steps.map(_toManualStep),
        ],
      ),
    );
  }
}

_ManualStep _toManualStep(_StepItem item) {
  return _ManualStep(
    no: item.no,
    title: item.title,
    description: item.description ?? '',
    icons: (item.icons ?? const <_StepIcon>[])
        .map((e) => _IconExplain(icon: e.icon, text: e.text))
        .toList(),
  );
}

BoxFit _mapFit(String? fitValue) {
  final String v = (fitValue ?? '').trim().toLowerCase();
  if (v.isEmpty) return BoxFit.fitWidth;
  return fit[v] ??
      (v == 'fitwidth'
          ? BoxFit.fitWidth
          : v == 'fitheight'
              ? BoxFit.fitHeight
              : BoxFit.fitWidth);
}

Widget _mapIcon(String? iconKey) {
  final String key = (iconKey ?? '').trim();
  if (key.isEmpty) {
    return const Icon(Icons.help_outline, color: Colors.grey);
  }
  return icons[key] ?? const Icon(Icons.help_outline, color: Colors.grey);
}

_StepItem _toStepItem(HelpDataItemsSteps step) {
  return _StepItem(
    no: step.no ?? 0,
    title: step.title ?? '',
    description: step.description ?? '',
    icons: (step.icons ?? <HelpDataItemsStepsIcons>[])
        .map((e) => _StepIcon(
              icon: _mapIcon(e.icon),
              text: e.text ?? '',
            ))
        .toList(),
  );
}

_StepEntity _toStepEntity(HelpDataItems item) {
  return _StepEntity(
    title: item.title ?? '',
    image: item.image ?? '',
    instruction: item.instruction ?? '',
    fit: _mapFit(item.fit),
    steps: (item.steps ?? <HelpDataItemsSteps>[])
        .map(_toStepItem)
        .toList(),
  );
}
