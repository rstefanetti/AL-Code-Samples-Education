codeunit 70000002 MySubscriber
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"MyPublishers", 'OnAddressLineChanged', '', true, true)]
    procedure CheckAddressLine(line : Text[100]);
    begin
        if (STRPOS(line, '+') > 0) then begin
            MESSAGE('Cannot use a plus sign (+) in the address [' + line + ']');
        end;
    end;
}