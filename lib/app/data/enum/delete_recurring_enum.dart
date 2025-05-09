enum DeleteRecurringEnum {
  oneMonth,
  all;

  bool get isOneMonth => this == DeleteRecurringEnum.oneMonth;
  bool get isAll => this == DeleteRecurringEnum.all;
}
