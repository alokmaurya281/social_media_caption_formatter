library social_media_caption_formatter;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class CustomReadMore extends StatefulWidget {
  final String text;
  TextAlign? textAlign;
  TextDirection? textDirection;
  Locale? locale;
  TextScaler? textScaler;
  ValueNotifier<bool>? isCollapsed;
  String? preDataText;
  String? postDataText;
  TextStyle? preDataTextStyle;
  TextStyle? postDataTextStyle;
  String trimExpandedText = 'show less';
  String trimCollapsedText = 'read more';
  Color? colorClickableText;
  int trimLength = 240;
  int trimLines = 2;
  TrimMode trimMode = TrimMode.Length;
  TextStyle? style;

  String? semanticsLabel;
  TextStyle? moreStyle;
  TextStyle? lessStyle;
  TextStyle? delimiterStyle;
  List<Annotation>? annotations;
  bool isExpandable = true;

  CustomReadMore({
    super.key,
    required this.text,
  });

  @override
  State<CustomReadMore> createState() => _CustomReadMoreState();
}

class _CustomReadMoreState extends State<CustomReadMore> {
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(fontSize: 14),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return ReadMoreText(
      widget.text,
      trimMode: TrimMode.Line,
      trimLines: 2,
      textAlign: TextAlign.justify,
      trimCollapsedText: 'Show more',
      trimExpandedText: ' Show less ',
      annotations: [
        // URL
        Annotation(
          regExp: RegExp(
            r'(?:(?:https?|ftp)://)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
          ),
          spanBuilder: ({
            required String text,
            TextStyle? textStyle,
          }) {
            return TextSpan(
              text: text,
              style: (textStyle ?? const TextStyle()).copyWith(
                decoration: TextDecoration.underline,
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _showMessage(text),
            );
          },
        ),

        Annotation(
          regExp: RegExp(r'@(?:[a-zA-Z0-9_]+)'),
          spanBuilder: ({
            required String text,
            TextStyle? textStyle,
          }) {
            return TextSpan(
              text: text,
              style: (textStyle ?? const TextStyle()).copyWith(
                color: Colors.blue,
                height: 1.5,
                letterSpacing: 3,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _showMessage(text),
            );
          },
        ),
        // Hashtag
        Annotation(
          // Test: non capturing group should work also
          regExp: RegExp('#(?:[a-zA-Z0-9_]+)'),
          spanBuilder: ({
            required String text,
            TextStyle? textStyle,
          }) {
            return TextSpan(
              text: text,
              style: (textStyle ?? const TextStyle()).copyWith(
                color: Colors.blueAccent,
                height: 1.5,
                letterSpacing: 3,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _showMessage(text),
            );
          },
        ),
      ],
    );
  }
}
