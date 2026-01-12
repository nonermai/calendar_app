//
// Copyright (c) 2025-2026 Renon Sumii. All rights reserved.
//

import 'package:calender_app/core/constants/app_layout.dart';
import 'package:calender_app/core/constants/app_string.dart';
import 'package:calender_app/core/theme/app_theme.dart';
import 'package:calender_app/core/widgets/liquid_glass_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

///
/// イベント追加時のダイアログクラス
///
class AddEventDialog extends StatefulWidget {
  const AddEventDialog({
    super.key,
    required this.initialDate,
    required this.onAddEvent,
  });

  // 初期表示日付
  final DateTime initialDate;

  // 追加ボタン押下時のコールバック関数
  final void Function(
    String title,
    DateTime startDate,
    DateTime endDate,
    Color color,
  )
  onAddEvent;

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  // テキストコントローラー
  late final TextEditingController _titleController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;

  // イベント開始日を保持する変数
  late DateTime _startDate;
  // イベント終了日を保持する変数
  late DateTime _endDate;
  // イベントの背景色を保持する変数(初期値はグレー)
  Color _eventColor = AppColor.thirdColor;
  // エラーメッセージ表示用変数
  String? _alertMessage;

  @override
  void initState() {
    super.initState();

    _startDate = widget.initialDate;
    _endDate = widget.initialDate;

    _titleController = TextEditingController();
    _startDateController = TextEditingController(
      text: _formatDate(_startDate),
    );
    _endDateController = TextEditingController(
      text: _formatDate(_endDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.2,
          horizontal: 24.0,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(
            AppLayout.addEventDialogBorderRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              // タイトル
              Text(
                AppString.newEvent,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 24),

              /// 予定入力テキストボックス
              SizedBox(
                width: AppLayout.eventTitleTextBoxWidth,
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: AppString.inputEvent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppLayout.eventTitleTextBoxBorderRadius,
                      ),
                    ),
                  ),
                ),
              ),
              if (_alertMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _alertMessage!,
                    style: TextStyle(color: AppColor.accentColor),
                  ),
                ),
              const SizedBox(
                height: AppLayout.eventTitleTextBoxBottomSpace,
              ),

              /// 日付選択
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dateField(
                    context: context,
                    label: AppString.startDate,
                    controller: _startDateController,
                    initialDate: _startDate,
                    onConfirm: (date) {
                      setState(() {
                        _startDate = date;
                        _startDateController.text = _formatDate(date);
                      });
                    },
                  ),
                  const Text(' 〜 '),
                  _dateField(
                    context: context,
                    label: AppString.endDate,
                    controller: _endDateController,
                    initialDate: _endDate,
                    onConfirm: (date) {
                      setState(() {
                        _endDate = date;
                        _endDateController.text = _formatDate(date);
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// 色選択
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppString.chooseBGColor),
                  const SizedBox(
                    width: AppLayout.chooseColorTextAndDropdownSpace,
                  ),
                  DropdownButton<Color>(
                    value: _eventColor,
                    items: AppColor.eventBackgroundColor.map((color) {
                      return DropdownMenuItem(
                        value: color,
                        child: Container(
                          width: AppLayout.previewColorWidth,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (color) {
                      if (color != null) {
                        setState(() => _eventColor = color);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),

              /// ボタン
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LiquidGlassButton(
                    width: AppLayout.buttonWidth,
                    child: Text(
                      AppString.cancel,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () {
                      setState(() => Navigator.pop(context));
                    },
                  ),
                  const SizedBox(
                    width: AppLayout.cancelAndAddButtonSpace,
                  ),
                  LiquidGlassButton(
                    width: AppLayout.buttonWidth,
                    child: Text(
                      AppString.add,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () {
                      setState(() => _onAddPressed());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // 日付フォーマット
  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  // 日付選択フィールド
  Widget _dateField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<DateTime> onConfirm,
    required BuildContext context,
    required DateTime initialDate,
  }) {
    return SizedBox(
      width: AppLayout.dateSelectionAreaWidth,
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppLayout.dateSelectionAreaBorderRadius,
            ),
          ),
        ),
        onTap: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            currentTime: initialDate,
            locale: LocaleType.jp,
            onConfirm: onConfirm,
          );
        },
      ),
    );
  }

  // 追加ボタン押下時の処理
  void _onAddPressed() {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      setState(() {
        _alertMessage = AppString.inputEventAlertMessage;
      });
      return;
    }

    widget.onAddEvent(
      title,
      _startDate,
      _endDate,
      _eventColor,
    );

    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}
