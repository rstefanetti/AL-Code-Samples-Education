codeunit 50102 EventsSubscriptions
{

    //Events Subscriptions

    // SET STORAGEKEY
    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnBeforeOnOpenPage', '', true, true)]
    local procedure "Item Card_OnBeforeOnOpenPage"(var Item: Record "Item")

    var
        StorageKey: text;

    begin
        StorageKey := 'itemNo';
        if IsolatedStorage.Contains(StorageKey, DataScope::CompanyAndUser) then 
            IsolatedStorage.Delete(StorageKey, DataScope::CompanyAndUser);
        IsolatedStorage.Set(StorageKey, Item."No.", DataScope::CompanyAndUser);
        Message(StorageKey);       
    end;


    // DELETE STORAGEKEY
    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnClosePageEvent', '', true, true)]
    local procedure "Item Card_OnClosePageEvent"(var Rec: Record "Item")

    var
        StorageKey: text;

    begin
        StorageKey := 'itemNo';
        if IsolatedStorage.Contains(StorageKey, DataScope::CompanyAndUser) then
            IsolatedStorage.Delete(StorageKey, DataScope::CompanyAndUser);
    end;


    //GET DATA FROM STORAGEKEY
    [EventSubscriber(ObjectType::Page, Page::"Units of Measure", 'OnOpenPageEvent', '', true, true)]
    local procedure "Units of Measure_OnOpenPageEvent"(var Rec: Record "Unit of Measure")

    var
        StorageKey: text;

    begin
        IsolatedStorage.Get('itemNo', DataScope::CompanyAndUser, StorageKey);
        message(StorageKey);
    end;




    //OnRun
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

}