codeunit 50105 MyEventPublisher
{
    [IntegrationEvent(false, false)]
    procedure OnAddressLineChanged(line : Text[100]);
    begin
    end;
}

codeunit 50106 MyEventSubscriber
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::MyEventPublisher, 'OnAddressLineChanged', '', true, true)]
    local procedure MyProcedure(line: Text[100])
    begin
    end;
}