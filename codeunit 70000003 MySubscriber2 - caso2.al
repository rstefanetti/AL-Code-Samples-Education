codeunit 70000003 MySubscriber2 (caso2)
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnBeforeValidateEvent', 'Address', true, true)]
    local procedure CheckAddressLine(var Rec : Record Customer)
    begin
        if (STRPOS('Rec.Address', '+') > 0) then begin
            MESSAGE('Cannot use a plus sign (+) in the address [' + 'Address' + ']');
        end;
    end;
}