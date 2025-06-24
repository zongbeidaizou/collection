import 'package:flutter/material.dart';
import 'package:bounty_hunter/goods/provider/goods_sort_provider.dart';
import 'package:bounty_hunter/goods/widgets/goods_sort_bottom_sheet.dart';
import 'package:bounty_hunter/res/resources.dart';
import 'package:bounty_hunter/routers/fluro_navigator.dart';
import 'package:bounty_hunter/util/device_utils.dart';
import 'package:bounty_hunter/util/theme_utils.dart';
import 'package:bounty_hunter/util/toast_utils.dart';
import 'package:bounty_hunter/widgets/click_item.dart';
import 'package:bounty_hunter/widgets/load_image.dart';
import 'package:bounty_hunter/widgets/my_app_bar.dart';
import 'package:bounty_hunter/widgets/my_button.dart';
import 'package:bounty_hunter/widgets/my_scroll_view.dart';
import 'package:bounty_hunter/widgets/selected_image.dart';
import 'package:bounty_hunter/widgets/text_field_item.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


/// design/4商品/index.html#artboard5
class SearchPage extends StatefulWidget {

  const SearchPage({
    super.key,
  });



  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String? _goodsSortName;
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          centerTitle:  'Search Orders' ,
          isBack: false,
        ),
        body: MyScrollView(
          key: const Key('goods_edit_page'),
          padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12),
          bottomButton: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: MyButton(
              onPressed: () => NavigatorUtils.goBack(context),
              text: 'Search',
            ),
          ),
          children: <Widget>[
            Gaps.vGap5,
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.disabled,
              name: 'sn',
              decoration: InputDecoration(
                labelText: 'SN',

              ),
              onChanged: (val) {
                setState(() {

                });
              },
              // valueTransformer: (text) => num.tryParse(text),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.max(70),
              ]),
              // initialValue: '12',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            Gaps.vGap5,
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.disabled,
              name: 'phone',
              decoration: InputDecoration(
                labelText: 'Phone',

              ),
              onChanged: (val) {
                setState(() {

                });
              },
              // valueTransformer: (text) => num.tryParse(text),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.max(70),
              ]),
              // initialValue: '12',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),

            FormBuilderFilterChip<String>(
              autovalidateMode: AutovalidateMode.disabled,
              decoration: const InputDecoration(
                  labelText: 'Status',
              ),
              name: 'languages_filter',
              selectedColor: Colors.blueAccent,
              // backgroundColor: Colors.grey,
              shadowColor: Colors.white,
              showCheckmark: false,
              spacing: 8,
              runSpacing: 2,
              options: const [
                FormBuilderChipOption(
                  value: 'Under negotiation',
                  avatar: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.sync, color: Colors.grey,)),
                ),
                FormBuilderChipOption(
                  value: 'Unable to dial',
                  avatar: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.phone_disabled, color: Colors.red,)),
                ),
                FormBuilderChipOption(
                  value: 'Promise to repay',
                  avatar: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.more_time, color: Colors.green,)),
                ),
                FormBuilderChipOption(
                  value: 'Refusal to repay ',
                  avatar: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.transfer_within_a_station, color: Colors.purpleAccent,)),
                ),

              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.minLength(1),
                FormBuilderValidators.maxLength(3),
              ]),
            ),


            Gaps.vGap32,
          ],
        )
    );
  }

  Widget tagsWidget(List<String> tags, Color tagColor, Color tagBackgroundColor) {
    return Container(
      child: Wrap(
        spacing: 3.0, // 主轴(水平)方向间距
        runSpacing: 3.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start, //沿主轴方向居中
        children: tags
            .map((tag) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: tagBackgroundColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              tag,
              style: TextStyle(color: tagColor, fontSize: Dimens.font_sp10),
            )))
            .toList(),
      ),
    );
  }


  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }


}
