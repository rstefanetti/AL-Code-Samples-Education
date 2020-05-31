pageextension 70000002 MyCustomerExt extends "Customer Card"
{
    layout
    {
        modify(Address)
        {
            trigger OnBeforeValidate();
            var
                Publisher: Codeunit 70000001;
            begin
                Publisher.OnAddressLineChanged(Address);
            end;
        }
    }
}