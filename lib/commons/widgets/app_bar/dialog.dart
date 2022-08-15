import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/extensions.dart';
import '../../utils/app_utils.dart';
import 'custom_loading/custom_loading_indicator.dart';

typedef DialogActionCallback = Function(bool hasAccepted);

abstract class DialogBase {
  late String content, title;
  late DialogActionCallback? _dialogActionCallback;
  late String? rightActionContent, leftActionContent;

  void init(String? content, String? title, String? leftActionContent,
      String? rightActionContent, DialogActionCallback? dialogActionCallback) {
    this.content = content ?? "";
    this.title = title ?? "";
    this.rightActionContent = rightActionContent;
    this.leftActionContent = leftActionContent;
    _dialogActionCallback = dialogActionCallback;
  }

  Widget buildDialog(BuildContext context);

  void onActionTap(bool value) {
    if (_dialogActionCallback != null) {
      _dialogActionCallback!(value);
    }
  }
}

class DialogFactory {
  DialogBase dialog;

  DialogFactory(
      {String? content,
      String? title,
      required this.dialog,
      String? leftActionContent,
      DialogActionCallback? dialogActionCallback,
      rightActionContent}) {
    dialog.init(content, title, leftActionContent, rightActionContent,
        dialogActionCallback);
  }

  Widget buildDialog(BuildContext context) => dialog.buildDialog(context);
}

class BasicDialog extends DialogBase {
  @override
  Widget buildDialog(context) {
    if (Platform.isAndroid) {
      return AlertDialog(
        content: Text(content),
        title: Text(title),
        actions: [
          if (!leftActionContent.isReallyEmpty())
            TextButton(
                onPressed: () {
                  onActionTap(false);
                },
                child: Text(leftActionContent!)),
          if (!rightActionContent.isReallyEmpty())
            TextButton(
                onPressed: () {
                  onActionTap(true);
                },
                child: Text(rightActionContent!))
        ],
      );
    }
    return CupertinoAlertDialog(
      content: Text(content),
      title: Text(title),
      actions: [
        if (!leftActionContent.isReallyEmpty())
          CupertinoDialogAction(
              onPressed: () {
                onActionTap(false);
              },
              child: Text(leftActionContent!)),
        if (!rightActionContent.isReallyEmpty())
          CupertinoDialogAction(
              onPressed: () {
                onActionTap(true);
              },
              child: Text(rightActionContent!))
      ],
    );
  }
}

class LoadingDialog extends DialogBase {
  @override
  Widget buildDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      titlePadding: EdgeInsets.zero,
      content: LoadingWidget(
        isLoading: true,
        child: const SizedBox(),
        color: AppUtils.getAppCubit(context).styles.defaultLoadMoreColor(),
      ),
    );
  }
}
