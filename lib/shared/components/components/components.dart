import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_appppp/layout/cubits/cubits.dart';
import 'package:todo_appppp/modules/edit_task/edit_task.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double height = 45.0,
  bool isUpperCase = true,
  double radius = 10.0,
  VoidCallback? function,
  required String text,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: background,
    ),
  );
}

Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

TextFormField defaultFormFieldF({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String>? validate,
  required String label,
  String? text,
  IconData? iconPrefix,
  IconData? suffix,
  FocusNode? focusNodes,
  Widget? suffixIcon,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  required GestureTapCallback onTab,
  bool isPassword = false,
  bool isClicked = true,
  bool autoFocused = false,
  EdgeInsetsGeometry? contentPadding = const EdgeInsets.all(4.0),
  double radiusEnable = 25.0,
  double radiusBorder = 25.0,
  int maxLinesL = 1,
  Color colorE = Colors.blueGrey,
  double radiusWidth = 2.0,
  TextAlignVertical? textAlignVertical = TextAlignVertical.top,
  bool readable = false,
}) {
  return TextFormField(
    maxLines: maxLinesL,
    controller: controller,
    keyboardType: type,
    enabled: isClicked,
    textAlignVertical: textAlignVertical,
    autofocus: autoFocused,
    focusNode: focusNodes,
    validator: validate,
    onTap: onTab,
    onChanged: onChanged,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    readOnly: readable,
    decoration: InputDecoration(
      contentPadding: contentPadding,
      label: Text(label),
      hintText: text,
      prefixIcon: Icon(iconPrefix),
      suffix: Icon(suffix),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusEnable),
        borderSide: BorderSide(
          color: colorE,
          width: radiusWidth,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusBorder),
        borderSide: const BorderSide(
          color: Colors.deepOrange,
        ),
      ),
    ),
  );
}

Widget myDivider({
  double paddingH = 7.0,
  double paddingV = 7.0,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingH,
        vertical: paddingV,
      ),
      child: Container(
        color: Colors.grey[400],
        height: 1.0,
        width: double.infinity,
      ),
    );

void navigatorTo(BuildContext ctx, Widget widget) => Navigator.push(
      ctx,
      MaterialPageRoute(builder: (ctx) => widget),
    );

void navigateAndFinish(BuildContext ctx, Widget widget) =>
    Navigator.pushAndRemoveUntil(
      ctx,
      MaterialPageRoute(builder: (ctx) => widget),
      (route) => false,
    );

void showToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: chooseToastState(state),
      textColor: Colors.white,
      fontSize: 20.0,
    );

enum ToastState { success, failed, warned }

Color chooseToastState(ToastState state) {
  switch (state) {
    case ToastState.success:
      return Colors.green;
    case ToastState.failed:
      return Colors.red;
    case ToastState.warned:
      return Colors.yellow;
  }
}

Widget listTasksItem(Map model, BuildContext context, Color color) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.blue,
            child: Text(
              '${model['date']}',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['name']}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${model['des']}',
                  style: const TextStyle(
                    color: Colors.black45,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () {
              AppCubit.get(context).changeData(status: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_box,
              color: color,
            ),
          ),
          const SizedBox(width: 2.0),
          IconButton(
            onPressed: () {
              navigatorTo(context, EditTask(id: model['id']));
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 2.0),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      titlePadding:
                          const EdgeInsets.only(top: 20.0, left: 24.0),
                      title: const Text(
                        'Do you want to delete this task?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      actions: [
                        Row(
                          children: [
                            defaultTextButton(
                              function: () {
                                AppCubit.get(context)
                                    .deleteData(id: model['id']);
                                Navigator.of(context).pop();
                              },
                              text: 'yes',
                            ),
                            const SizedBox(width: 5.0),
                            defaultTextButton(
                              function: () {
                                Navigator.of(context).pop();
                              },
                              text: 'no',
                            ),
                          ],
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
