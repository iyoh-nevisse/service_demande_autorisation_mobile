// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, file_names, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace, unnecessary_const, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demandeautorisation/utils/app_colors.dart';

import 'package:demandeautorisation/utils/app_constant.dart';
import 'package:demandeautorisation/utils/variables.dart';

Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: textColor ,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: shadowColorGlobal) : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}



Widget settingItem(context, String text, {Function? onTap, Widget? detail, Widget? leading, Color? textColor, int? textSize, double? padding}) {
  return InkWell(
    onTap: onTap as void Function()?,
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: padding ?? 8, bottom: padding ?? 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(child: leading ?? const SizedBox(), width: 30, alignment: Alignment.center),
              leading != null ? 10.width : const SizedBox(),
              Text(text, style: primaryTextStyle(size: textSize ?? 18, color: textColor )).expand(),
            ],
          ).expand(),
          detail ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
        ],
      ).paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
    ),
  );
}

Widget appBarTitleWidget(context, String title, {Color? color, Color? textColor}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    color: color ,
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: boldTextStyle(color: color, size: 20),
          maxLines: 1,
        ).expand(),
      ],
    ),
  );
}

AppBar appBar(BuildContext context, String title, {List<Widget>? actions, bool showBack = true, Color? color, Color? iconColor, Color? textColor}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: color,
    leading: showBack
        ? IconButton(
            onPressed: () {
              finish(context);
            },
            icon: const Icon(Icons.arrow_back),
          )
        : null,
    title: appBarTitleWidget(context, title, textColor: textColor, color: color),
    actions: actions,
    elevation: 0.5,
  );
}



String convertDate(date) {
  try {
    return date != null ? DateFormat(dateFormat).format(DateTime.parse(date)) : '';
  } catch (e) {
    print(e);
    return '';
  }
}

class CustomTheme extends StatelessWidget {
  final Widget? child;

  const CustomTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    throw UnimplementedError();
  }

 
}


// ignore: must_be_immutable
class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var hint;
  var maxLine;
  TextEditingController? mController;

  VoidCallback? onPressed;

  EditText(
      {var this.fontSize = textSizeNormal,
      var this.textColor = TextColorSecondary2,
      var this.fontFamily = fontRegular,
      var this.isPassword = true,
      var this.hint = "",
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.mController,
      obscureText: widget.isPassword,
      style: const TextStyle(
          color: Colors.white,
          fontSize: textSizeLargeMedium,
          fontFamily: fontRegular),
      decoration: InputDecoration(
        suffixIcon: widget.isSecure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: Icon(
                  widget.isPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        hintText: widget.hint,
        hintStyle:const  TextStyle(color: TextColorThird2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: ViewColor2, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: ViewColor2, width: 0.0),
        ),
      ),
    );
  }
}

TextFormField editTextStyle(var hintText, {isPassword = true}) {
  return TextFormField(
    style:
        const TextStyle(fontSize: textSizeLargeMedium, fontFamily: fontRegular),
    obscureText: isPassword,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      hintText: hintText,
      hintStyle: const TextStyle(color: TextColorThird2),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: ViewColor2, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: ViewColor2, width: 0.0),
      ),
    ),
  );
}

Widget checkbox(String title, bool? boolValue) {
  return Row(
    children: <Widget>[
      Text(title),
      Checkbox(
        activeColor: ColorPrimary2,
        value: boolValue,
        onChanged: (bool? value) {
          boolValue = value;
        },
      )
    ],
  );
}

// ignore: must_be_immutable
class TopBar extends StatefulWidget {
  var titleName;

  TopBar({var this.titleName = ""});

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.keyboard_arrow_left, size: 45),
            //   onPressed: () {
            //     finish(context);
            //   },
            // ),
            Center(
                child: Text(widget.titleName,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: textSizeNormal,
                        fontFamily: fontBold)))
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HorizontalTab extends StatefulWidget {
  final List<String> images;
  var currentIndexPage = 0;

  HorizontalTab(this.images);

  @override
  State<StatefulWidget> createState() {
    return HorizontalTabState();
  }
}

class HorizontalTabState extends State<HorizontalTab> {
  //final VoidCallback loadMore;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 40;
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2,
          // ignore: todo
          // TODO Without NullSafety SnapList
          /*child: SnapList(
            padding: EdgeInsets.only(left: 16),
            sizeProvider: (index, data) => cardSize,
            separatorProvider: (index, data) => Size(12, 12),
            positionUpdate: (int index) {
              widget.currentIndexPage = index;
            },
            builder: (context, index, data) {
              return ClipRRect(
                borderRadius: new BorderRadius.circular(12.0),
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.fill,
                ),
              );
            },
            count: widget.images.length,
          ),*/
        ),
      ],
    );
  }
}

Widget ring(String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(
            width: 16.0,
            color: ColorPrimary2,
          ),
        ),
      ),
      const SizedBox(height: 16),
      // text(description, textColor: appStore.textPrimaryColor, fontSize: textSizeNormal, fontFamily: fontSemibold, isCentered: true, maxLine: 2)
    ],
  );
}

Widget shareIcon(String iconPath) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.fill),
  );
}

class Slider extends StatelessWidget {
  final String file;

  const Slider({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset(file, fit: BoxFit.fill),
      ),
    );
  }
}

class PinEntryTextField extends StatefulWidget {
  final String? lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  // ignore: prefer_equal_for_default_values
  const PinEntryTextField(
      {this.lastPin,
      this.fields = 4,
      this.onSubmit,
      this.fieldWidth = 40.0,
      this.fontSize = 20.0,
      this.isTextObscure = false,
      this.showFieldAsBox = false})
      : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  late List<String?> _pin;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String?>.filled(widget.fields, null, growable: false);
    _focusNodes = List<FocusNode?>.filled(widget.fields, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.fields, null,
        growable: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin!.length; i++) {
            _pin[i] = widget.lastPin![i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController? t) => t!.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController? tEditController) => tEditController!.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i]!.text = widget.lastPin![i];
      }
    }

    _focusNodes[i]!.addListener(() {
      if (_focusNodes[i]!.hasFocus) {}
    });

    return Container(
      width: widget.fieldWidth,
      margin: const EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: fontMedium,
            fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
          counterText: "",
          border: widget.showFieldAsBox
              ? const OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0, color: Colors.blue),
                )
              : null,
          // ignore: prefer_const_constructors
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
          ),
          // ignore: prefer_const_constructors
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: TextColorPrimary2),
          ),
        ),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i]!.unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i]!.unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}

Widget divider() {
  return const Divider(
    height: 0.5,
    color: ViewColor2,
  );
}



Padding t3EditTextField(var hintText, {isPassword = true}) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextFormField(
        style: primaryTextStyle(size: 18),
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(26, 18, 4, 18),
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFFF5F4F4),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color(0xFFF5F4F4), width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color(0xFFF5F4F4), width: 0.0),
          ),
        ),
      ));
}

// ignore: must_be_immutable
class T3AppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  T3AppButton({required this.textContent, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return T3AppButtonState();
  }
}

class T3AppButtonState extends State<T3AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)), padding: const EdgeInsets.all(0.0), elevation: 4, textStyle: const TextStyle(color: Colors.white)),
      child: Container(
        decoration: const BoxDecoration(
          color: Variables.primaryColor,
          borderRadius: BorderRadius.all(const Radius.circular(80.0)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              widget.textContent,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class T3AppBar extends StatefulWidget {
  var titleName;

  T3AppBar(var this.titleName);

  @override
  State<StatefulWidget> createState() {
    return T3AppBarState();
  }
}

class T3AppBarState extends State<T3AppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: const Color(0xFFffffff),
                  onPressed: () {
                    finish(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Center(
                    child: Text(
                      widget.titleName,
                      maxLines: 2,
                      style: boldTextStyle(size: 22, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const CircleAvatar(
                // backgroundImage: CachedNetworkImageProvider(t3_ic_profile),
                radius: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget commonCacheImageWidget(String? url, double height,
    {double? width, BoxFit? fit}) {
  if (url.validate().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        // placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        errorWidget: (_, __, ___) {
          return SizedBox(height: height, width: width);
        },
      );
    } else {
      return Image.network(url!,
          height: height, width: width, fit: fit ?? BoxFit.cover);
    }
  } else {
    return Image.asset(url!,
        height: height, width: width, fit: fit ?? BoxFit.cover);
  }
}
