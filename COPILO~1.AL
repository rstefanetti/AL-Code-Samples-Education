codeunit 54001 MyCopilotCodeunitDemo1
{
    trigger OnRun()
    begin

    end;


    // TEST COPILOT
    local procedure MyItems()
    var
        item: Record Item;
        customer: Record customer;


    begin
        item.SetRange(Blocked, false);
        item.SetRange("No.", '1000');

        if item.FindSet() then
            repeat
                if item.Description = 'Test' then
                    item.Description := 'Test 2';
                item.Modify();
            until item.Next() = 0;
    end;


    var
        myInt: Integer;


}