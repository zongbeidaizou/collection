import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Manual'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const _IntroSection(),
          const SizedBox(height: 12),
          const _GlobalIconSection(),
          const SizedBox(height: 12),
          _MenuSection(
            title: 'Case',
            purpose:
                'Manage daily collection cases and follow each borrower status from new assignment to promise-to-pay.',
            iconNotes: <_IconMeaning>[
              _IconMeaning(icon: Icon(Icons.app_registration_rounded), text: 'Cases menu entry'),
              _IconMeaning(icon: Icon(Icons.group_add), text: 'Add All Cases Contacts to Phone'),
              _IconMeaning(icon: Icon(Icons.search), text: 'Search cases'),
              _IconMeaning(icon: Icon(Icons.description_outlined), text: 'Open Log page'),
              _IconMeaning(icon: Icon(Icons.miscellaneous_services), text: 'New'),
              _IconMeaning(icon: Icon(Icons.sync), text: 'Negotiating'),
              _IconMeaning(icon: Icon(Icons.more_time), text: 'PTP (Promise to Pay)'),
              _IconMeaning(icon: Icon(Icons.hourglass_disabled), text: 'BP / overdue promise state'),
              _IconMeaning(icon: Icon(Icons.phone_disabled), text: 'No Answer'),
            ],
            operations: <String>[
              'Switch tabs to focus on one workflow stage.',
              'Use the search field to find target borrowers quickly.',
              'Open a case item and update communication results in time.',
              'Use "Log" to review actions and history across statuses.',
            ],

          ),
          const SizedBox(height: 12),
          _MenuSection(
            title: 'Marketing',
            purpose:
                'Track marketing leads, apply templates, and monitor engagement/response results.',
            iconNotes: <_IconMeaning>[
              _IconMeaning(icon: Icon(Icons.tty), text: 'Marketing menu entry'),
              _IconMeaning(icon: Icon(Icons.looks_one), text: 'Red number badge means today pending/updated count'),
              _IconMeaning(icon: Icon(Icons.label_important_outline), text: 'Category marker in list card'),
            ],
            operations: <String>[
              'Pull to refresh latest marketing leads.',
              'Search by phone (normalized digits) to locate a lead.',
              'Use template-based outreach where available.',
              'Review updates periodically because page data auto-refreshes.',
            ],

          ),
          const SizedBox(height: 12),
          _MenuSection(
            title: 'Receive',
            purpose:
                'Search and receive online assignments/orders for further processing.',
            iconNotes: <_IconMeaning>[
              _IconMeaning(icon: Icon(Icons.move_up), text: 'Receive menu entry'),
              _IconMeaning(icon: Icon(Icons.circle, color: Colors.red, size: 10), text: 'Red dot means pending attention'),
              _IconMeaning(icon: Icon(Icons.manage_search), text: 'Search by online phone number'),
            ],
            operations: <String>[
              'Input phone keyword and submit search.',
              'Open matched results and claim/receive available records.',
              'Follow up in Case/Log workflow after receiving.',
            ],

          ),
          const SizedBox(height: 12),
          _MenuSection(
            title: 'Bonus',
            purpose:
                'Review commission/bonus records and monitor payout-related activities.',
            iconNotes: <_IconMeaning>[
              _IconMeaning(icon: Icon(Icons.iso), text: 'Bonus menu entry'),
              _IconMeaning(icon: Icon(Icons.looks_one), text: 'Red number badge = new bonus records'),
              _IconMeaning(icon: Icon(Icons.money_off_csred_outlined), text: 'Penalty'),
              _IconMeaning(icon: Icon(Icons.lens), text: 'Settled'),
              _IconMeaning(icon: Icon(Icons.my_location), text: 'Achievement'),
              _IconMeaning(icon: Icon(Icons.nightlight), text: 'Partial Repayment'),
              _IconMeaning(icon: Icon(Icons.bar_chart_rounded), text: 'Weekly Ranking Bonus'),
              _IconMeaning(icon: Icon(Icons.golf_course), text: 'Monthly Bonus'),
              _IconMeaning(icon: Icon(Icons.transfer_within_a_station), text: 'Transfer Bonus'),
              _IconMeaning(icon: Icon(Icons.extension_outlined), text: 'Extension Bonus'),
              _IconMeaning(icon: Icon(Icons.person_outline_outlined), text: 'Registration Bonus'),
              _IconMeaning(icon: Icon(Icons.how_to_reg_outlined), text: 'Application Bonus'),
              _IconMeaning(icon: Icon(Icons.build_outlined), text: 'Manual payout/adjustment'),
            ],
            operations: <String>[
              'Pull to refresh latest bonus records.',
              'Filter records by phone to validate target transactions.',
              'Scroll to load more historical records.',
            ],

          ),
          const SizedBox(height: 12),
          _MenuSection(
            title: 'News',
            purpose:
                'Read platform notifications, category alerts, and operational reminders.',
            iconNotes: <_IconMeaning>[
              _IconMeaning(icon: Icon(Icons.campaign_sharp), text: 'News menu entry'),
              _IconMeaning(icon: Icon(Icons.looks_one), text: 'Red number badge = unread notifications'),
              _IconMeaning(icon: Icon(Icons.circle, size: 10), text: 'Category color dot in each notification card'),
            ],
            operations: <String>[
              'Pull to refresh latest notifications.',
              'Scroll for historical messages.',
              'Prioritize unread cards with stronger visual highlight.',
            ],

          ),
          const SizedBox(height: 12),
          _MenuSection(
            title: 'Account',
            purpose:
                'View personal dashboard, rankings, progress, and account-related settings.',
            iconNotes: <_IconMeaning>[
              _IconMeaning(icon: Icon(Icons.emoji_events_rounded), text: 'Account menu entry'),
              _IconMeaning(icon: Icon(Icons.menu_book), text: 'Open this user manual'),
              _IconMeaning(icon: Icon(Icons.calendar_month), text: 'Day details'),
              _IconMeaning(icon: Icon(Icons.edit_note), text: 'Edit message template'),
              _IconMeaning(icon: FaIcon(FontAwesomeIcons.squareWhatsapp), text: 'WhatsApp activation'),
              _IconMeaning(icon: Icon(Icons.settings), text: 'General settings'),
            ],
            operations: <String>[
              'Review dashboard charts for weekly and monthly trends.',
              'Use rankings to compare team/person performance.',
              'Maintain templates and channel settings from top actions.',
            ],

          ),
          const SizedBox(height: 12),
          _MenuSection(
            title: 'Log',
            purpose:
                'Audit communication and operation history by outcome type for traceability.',
            iconNotes: <_IconMeaning>[
              _IconMeaning(icon: Icon(Icons.description_outlined), text: 'Entry icon from Case page'),
              _IconMeaning(icon: Icon(Icons.content_paste_search_outlined), text: 'Search logs'),
              _IconMeaning(icon: Icon(Icons.hourglass_disabled), text: 'BP'),
              _IconMeaning(icon: Icon(Icons.nightlight), text: 'Part Pay'),
              _IconMeaning(icon: Icon(Icons.more_time), text: 'PTP'),
              _IconMeaning(icon: Icon(Icons.extension_outlined), text: 'Extension'),
              _IconMeaning(icon: Icon(Icons.repeat_one), text: 'Retain'),
              _IconMeaning(icon: Icon(Icons.move_up), text: 'Receive'),
              _IconMeaning(icon: Icon(Icons.loupe), text: 'Admin'),
              _IconMeaning(icon: Icon(Icons.sync), text: 'Negotiation'),
            ],
            operations: <String>[
              'Switch tabs to inspect one log type at a time.',
              'Use search to locate specific phone/order traces.',
              'Open items to validate chronology and responsibility.',
            ],
          ),
          const SizedBox(height: 20),
          const _FooterNote(),
        ],
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Collection App Manual',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This page explains major menus, icon meanings, and common actions. '
            ),
          ],
        ),
      ),
    );
  }
}

class _GlobalIconSection extends StatelessWidget {
  const _GlobalIconSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Global Visual Rules',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('- Red number badge: new/unread/newly assigned count'),
            Text('- Red dot badge: pending attention indicator'),
            Text('- Pull-to-refresh: manually reload latest data'),
            Text('- Infinite scroll: load more records when reaching list bottom'),
          ],
        ),
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    required this.title,
    required this.purpose,
    required this.iconNotes,
    required this.operations,
  });

  final String title;
  final String purpose;
  final List<_IconMeaning> iconNotes;
  final List<String> operations;

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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text('Purpose: $purpose'),
            const SizedBox(height: 10),
            const Text(
              'Icon meanings',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            ...iconNotes.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 24, child: Center(child: e.icon)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(e.text)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'How to operate',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            ...operations.map((e) => Text('- $e')),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}

class _IconMeaning {
  const _IconMeaning({
    required this.icon,
    required this.text,
  });

  final Widget icon;
  final String text;
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Last update: ${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
