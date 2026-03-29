import 'package:bounty_hunter/res/colors.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        body: const TabBarView(
          children: <Widget>[
            _ManualTabView(
              moduleName: 'Cases',
              overview:
                  'The Cases module is the daily operation center for collection tasks. Use it to filter by status, contact borrowers, update outcomes, and check processing history.',
              screenshotTitle: 'Example Screenshot - Cases Main Workflow',
              screenshotHint:
                  'This screenshot marks steps 1~8. See the list below for detailed meanings.',
              markerIcons: <IconData>[
                Icons.app_registration_rounded,
                Icons.search,
                Icons.assignment_turned_in_outlined,
                Icons.description_outlined,
              ],
              imageAsset: 'assets/images/manual/case_list.png',
              imageFirst: true,
              steps: <_ManualStep>[
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
              ],
            ),
            _ManualTabView(
              moduleName: 'Marketing',
              overview:
                  'The Marketing module tracks lead outreach and communication templates. It helps teams follow campaign execution and response updates.',
              screenshotTitle: 'Example Screenshot - Marketing List',
              screenshotHint:
                  'Replace this with a real screenshot containing markers 1, 2, and 3.',
              markerIcons: <IconData>[
                Icons.tty,
                Icons.manage_search,
                Icons.message,
              ],
              steps: <_ManualStep>[
                _ManualStep(
                  no: 1,
                  title: 'Open lead queue',
                  description: 'Check today lead updates and unread counts first.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.tty), text: 'Marketing module entry'),
                    _IconExplain(icon: Icon(Icons.looks_one), text: 'Red badge = pending updates'),
                  ],
                ),
                _ManualStep(
                  no: 2,
                  title: 'Search by phone',
                  description: 'Filter records quickly using normalized phone input.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.manage_search), text: 'Search leads'),
                  ],
                ),
                _ManualStep(
                  no: 3,
                  title: 'Execute outreach',
                  description: 'Send messages with templates and record campaign progress.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.message), text: 'Message interaction'),
                  ],
                ),
              ],
            ),
            _ManualTabView(
              moduleName: 'Receive',
              overview:
                  'The Receive module is used to find and claim online assignments. Teams can search, open results, and receive eligible records.',
              screenshotTitle: 'Example Screenshot - Receive Search',
              screenshotHint:
                  'Replace this with a screenshot that shows markers 1, 2, and 3.',
              markerIcons: <IconData>[
                Icons.move_up,
                Icons.manage_search,
                Icons.assignment_turned_in_outlined,
              ],
              steps: <_ManualStep>[
                _ManualStep(
                  no: 1,
                  title: 'Enter Receive module',
                  description: 'Open Receive from bottom tab before searching.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.move_up), text: 'Receive entry'),
                    _IconExplain(icon: Icon(Icons.circle, color: Colors.red, size: 10), text: 'Red dot = pending attention'),
                  ],
                ),
                _ManualStep(
                  no: 2,
                  title: 'Search online records',
                  description: 'Input phone keyword and submit search.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.manage_search), text: 'Search online records'),
                  ],
                ),
                _ManualStep(
                  no: 3,
                  title: 'Receive assignment',
                  description: 'Open results and claim records for follow-up.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.assignment_turned_in_outlined), text: 'Confirm receive'),
                  ],
                ),
              ],
            ),
            _ManualTabView(
              moduleName: 'Bonus',
              overview:
                  'The Bonus module displays commission records and payout types. It is used for verification and historical review of bonus activities.',
              screenshotTitle: 'Example Screenshot - Bonus Records',
              screenshotHint:
                  'Replace this with a screenshot that shows markers 1, 2, and 3.',
              markerIcons: <IconData>[
                Icons.iso,
                Icons.manage_search,
                Icons.bar_chart_rounded,
              ],
              steps: <_ManualStep>[
                _ManualStep(
                  no: 1,
                  title: 'Open bonus list',
                  description: 'Review new bonus items and recent transactions.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.iso), text: 'Bonus module entry'),
                    _IconExplain(icon: Icon(Icons.looks_one), text: 'Red badge = new bonus records'),
                  ],
                ),
                _ManualStep(
                  no: 2,
                  title: 'Filter target record',
                  description: 'Use search/filter by phone to locate payout details.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.manage_search), text: 'Search bonus record'),
                  ],
                ),
                _ManualStep(
                  no: 3,
                  title: 'Interpret bonus type',
                  description: 'Read icon type to understand settlement, penalty, or ranking bonus.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.lens), text: 'Settled'),
                    _IconExplain(icon: Icon(Icons.money_off_csred_outlined), text: 'Penalty'),
                    _IconExplain(icon: Icon(Icons.bar_chart_rounded), text: 'Weekly ranking bonus'),
                  ],
                ),
              ],
            ),
            _ManualTabView(
              moduleName: 'Account',
              overview:
                  'The Account module is the personal dashboard for rankings, progress, and quick tools like templates, WhatsApp activation, and settings.',
              screenshotTitle: 'Example Screenshot - Account Dashboard',
              screenshotHint:
                  'Replace this with a screenshot that shows markers 1, 2, 3, 4, and 5.',
              markerIcons: <IconData>[
                Icons.menu_book,
                Icons.calendar_month,
                Icons.edit_note,
                FontAwesomeIcons.squareWhatsapp,
                Icons.settings,
              ],
              steps: <_ManualStep>[
                _ManualStep(
                  no: 1,
                  title: 'Open manual',
                  description: 'Use manual icon to open this guide page.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.menu_book), text: 'Manual'),
                  ],
                ),
                _ManualStep(
                  no: 2,
                  title: 'Check day details',
                  description: 'Open day details dialog for quick status overview.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.calendar_month), text: 'Day details'),
                  ],
                ),
                _ManualStep(
                  no: 3,
                  title: 'Edit message templates',
                  description: 'Maintain predefined note or messaging templates.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.edit_note), text: 'Message templates'),
                  ],
                ),
                _ManualStep(
                  no: 4,
                  title: 'Activate WhatsApp',
                  description: 'Open WA activation page for channel setup.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: FaIcon(FontAwesomeIcons.squareWhatsapp), text: 'WA activation'),
                  ],
                ),
                _ManualStep(
                  no: 5,
                  title: 'Open settings',
                  description: 'Configure general account and app options.',
                  icons: <_IconExplain>[
                    _IconExplain(icon: Icon(Icons.settings), text: 'Settings'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ManualTabView extends StatelessWidget {
  const _ManualTabView({
    required this.moduleName,
    required this.overview,
    required this.screenshotTitle,
    required this.screenshotHint,
    required this.markerIcons,
    required this.steps,
    this.imageAsset,
    this.imageFirst = false,
  });

  final String moduleName;
  final String overview;
  final String screenshotTitle;
  final String screenshotHint;
  final List<IconData> markerIcons;
  final List<_ManualStep> steps;
  final String? imageAsset;
  final bool imageFirst;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        if (!imageFirst) _SectionCard(
          title: '$moduleName Overview',
          child: Text(overview),
        ),
        if (!imageFirst) const SizedBox(height: 12),
        _SectionCard(
          title: screenshotTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (imageAsset == null)
                _ScreenshotPlaceholder(
                  markerIcons: markerIcons,
                  hint: screenshotHint,
                )
              else
                _ScreenshotImage(asset: imageAsset!, hint: screenshotHint),
              const SizedBox(height: 12),
              const Text(
                'Step-by-Step Instructions',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...steps,
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (imageFirst) _SectionCard(
          title: '$moduleName Overview',
          child: Text(overview),
        ),
        const SizedBox(height: 12),
      ],
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

class _ScreenshotPlaceholder extends StatelessWidget {
  const _ScreenshotPlaceholder({
    required this.markerIcons,
    required this.hint,
  });

  final List<IconData> markerIcons;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueGrey.withOpacity(0.25)),
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    'Screenshot Area',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey.shade400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      children: List<Widget>.generate(markerIcons.length, (index) {
                        return _MarkerBubble(
                          no: index + 1,
                          icon: markerIcons[index],
                        );
                      }),
                    ),
                  ),
                ),
              ],
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

class _MarkerBubble extends StatelessWidget {
  const _MarkerBubble({
    required this.no,
    required this.icon,
  });

  final int no;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 9,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              '$no',
              style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 6),
          Icon(icon, size: 14),
        ],
      ),
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
