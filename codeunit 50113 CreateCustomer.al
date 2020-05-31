codeunit 50113 CreateCustomer
{
    TableNo = Customer;
    trigger OnRun();
    begin
        CheckSize(Rec);
    end;
    procedure CheckSize(var Cust : Record Customer)
    begin
        if not Cust.HasShoeSize() then
            Cust.ShoeSize := 42;
    end;
}