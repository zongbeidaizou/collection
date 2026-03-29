import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:flutter/material.dart';

class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = ThemeUtils.getIconColor(context);
    final bool isDark = context.isDark;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            tooltip: 'Back',
            onPressed: () => NavigatorUtils.goBack(context),
            icon: Icon(Icons.arrow_back, color: iconColor ?? Colors.white),
          ),
          centerTitle: true,
          title: Text('Help Center', style: TextStyle(color: ThemeUtils.getIconColor(context))),
          flexibleSpace:  isDark
            ? Container(
                height: 115.0,
                color: Colours.dark_bg_color,
              )
            : LoadAssetImage(
                'statistic/statistic_bg',
                height: 115.0,
                fit: BoxFit.fill,
              ),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colours.app_main,
            unselectedLabelColor: Colours.text_gray,
            indicatorColor: Colours.app_main,
            tabs: <Tab>[
              Tab(text: 'Cases'),
              Tab(text: 'Marketing'),
              Tab(text: 'Receive'),
              Tab(text: 'Bonus'),
              Tab(text: 'Account'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.all(16),
              children: List<Widget>.generate(3, (int index) {
                return _SectionCard(
                  title: 'Example Screenshot - Cases Main Workflow',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const _ScreenshotImage(
                        asset: 'assets/images/manual/case_list.png',
                        hint:
                            'This screenshot marks steps 1~8. See the list below for detailed meanings.',
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Step-by-Step Instructions',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      ..._buildCaseSteps(),
                    ],
                  ),
                );
              }),
            ),
            
            
            
          ],
        ),
      ),
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
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
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
  });

  final String asset;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueGrey.withOpacity(0.25)),
            ),
            clipBehavior: Clip.antiAlias,
            child: LoadAssetImage(
              asset,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          hint,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 12,
          ),
        ),
      ],
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
                radius: 11,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  '$no',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(description),
          if (icons.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            const Text(
              'Icon explanations',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
            const SizedBox(height: 4),
            ...icons,
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
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

List<_ManualStep> _buildCaseSteps() {
  return const <_ManualStep>[
    _ManualStep(
      no: 1,
      title: 'Header and segment indicator',
      description: 'Shows leading segment or priority label of the case list item.',
      icons: <_IconExplain>[
        _IconExplain(icon: Icon(Icons.label_important_outline), text: 'Segment/priority badge'),
      ],
    ),
    _ManualStep(
      no: 2,
      title: 'Commission/Rate indicator',
      description: 'Shows current applicable rate or commission percentage.',
      icons: <_IconExplain>[
        _IconExplain(icon: Icon(Icons.percent), text: 'Rate'),
      ],
    ),
    _ManualStep(
      no: 3,
      title: 'Tag and count area',
      description: 'Displays tags such as attempts or group labels with counts.',
      icons: <_IconExplain>[
        _IconExplain(icon: Icon(Icons.sell_outlined), text: 'Tag'),
        _IconExplain(icon: Icon(Icons.confirmation_number_outlined), text: 'Count'),
      ],
    ),
    _ManualStep(
      no: 4,
      title: 'Borrower basic info',
      description: 'Includes masked name and masked phone number.',
      icons: <_IconExplain>[
        _IconExplain(icon: Icon(Icons.person_outline), text: 'Masked name'),
        _IconExplain(icon: Icon(Icons.phone_android), text: 'Masked phone'),
      ],
    ),
    _ManualStep(
      no: 5,
      title: 'Last record and countdown',
      description: 'Shows remaining time and last record timestamp for the case.',
      icons: <_IconExplain>[
        _IconExplain(icon: Icon(Icons.timer), text: 'Remaining time'),
        _IconExplain(icon: Icon(Icons.history), text: 'Last record'),
      ],
    ),
    _ManualStep(
      no: 6,
      title: 'Bonus panel',
      description: 'Displays expected bonus summary with level and amount.',
      icons: <_IconExplain>[
        _IconExplain(icon: Icon(Icons.attach_money), text: 'Bonus'),
        _IconExplain(icon: Icon(Icons.star_border), text: 'Level'),
      ],
    ),
    _ManualStep(
      no: 7,
      title: 'Latest note preview',
      description: 'Shows the latest communication note content inline.',
      icons: <_IconExplain>[
        _IconExplain(icon: Icon(Icons.notes), text: 'Note'),
      ],
    ),
    _ManualStep(
      no: 8,
      title: 'Action buttons',
      description: 'Perform quick actions such as Retain or open Detail page.',
      icons: <_IconExplain>[
        _IconExplain(icon: Icon(Icons.repeat_one), text: 'Retain'),
        _IconExplain(icon: Icon(Icons.info_outline), text: 'Detail'),
      ],
    ),
  ];
}
