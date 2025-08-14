import 'package:game_assistant/themes/colors/colors.dart';
import 'package:game_assistant/themes/styles/text_style.dart';
import 'package:game_assistant/utils/app_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentItem extends StatelessWidget {
  final String? content;
  const ContentItem({
    super.key,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: buildExtractMessage(
          AppUtils.removeSpecificSymbols(
            content ?? '',
          ),
        ),
      ),
    );
  }

  List<TextSpan> buildExtractMessage(String rawString) {
    List<TextSpan> textSpan = [];
    final urlRegExp = RegExp(
        r'((https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9@:%_\+.~#?&/=]*)?');
    String getLink(String linkString) {
      textSpan.add(
        TextSpan(
          text: linkString,
          style: bigStyle.copyWith(
            color: blueColor,
          ),
          recognizer: TapGestureRecognizer()..onTap = () async => await launchUrl(Uri.parse(linkString)),
        ),
      );
      return linkString;
    }

    String getNormalText(String normalText) {
      textSpan.add(
        TextSpan(
          text: normalText,
          style: bigStyle.copyWith(
            color: blackColor,
          ),
        ),
      );
      return normalText;
    }

    rawString.splitMapJoin(
      urlRegExp,
      onMatch: (m) => getLink('${m.group(0)}'),
      onNonMatch: (n) => getNormalText(n.substring(0)),
    );

    return textSpan;
  }
}
