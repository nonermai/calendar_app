//
// Copyright (c) 2025 sumiirenon. All rights reserved.
//

class AppDuration {
  // コントローラーがAttachされるまでの遅延時間
  // 遅延しないと、Attach前にアクセスしてしまいエラーになる
  static const Duration controllerAttachCheckDelay = Duration(milliseconds: 50);
  // 今月に戻るボタン押下時のアニメーション時間
  static const Duration backToCurrentMonthAnimation = Duration(
    milliseconds: 600,
  );
}
