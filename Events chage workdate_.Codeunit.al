codeunit 70000 "SEDP Events chage workdate"
{
  EventSubscriberInstance = StaticAutomatic;

  [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Action Triggers", 'GetNotificationStatus', '', true, true)]
  procedure GetNotificationStatus(NotificationId: Guid;
  var IsEnabled: Boolean)begin
    WorkDate(Today);
  end;
}
