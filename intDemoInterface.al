interface TestInt
{
    Procedure PrintHallo()  //Print Hallo Void container declaration
}


codeunit 50102 Test implements TestInt
{
    procedure PrintHallo()
    begin
        Message('Hallo');
    end;
}



pageextension 50105 ItemListCustom extends "Item List"
{
    trigger OnOpenPage()
    var 
      intInterface: Interface TestInt;     //Interface - new object !!   
      cduCodeunit: Codeunit Test;          //Codeunit - implementing new Interface
    
    begin
        intInterface := cduCodeunit;  // We tell the interface to use the cduCodeunit implementation of our functions.
        locPrintHallo(intInterface);
    end;

    local procedure locPrintHallo(TestInt: Interface TestInt)
    begin
        TestInt.PrintHallo();  //Interface Print 'Hallo' on OnOpePage trigger
    end;

}




//Interface - Microsoft Example
interface IAddressProvider
{
    procedure GetAddress(): Text;
}

codeunit 50200 CompanyAddressProvider implements IAddressProvider
{
    procedure GetAddress(): Text;

    begin
        exit('Company address \ Denmark 2800')
    end;
}

codeunit 50201 PrivateAddressProvider implements IAddressProvider
{
    procedure GetAddress(): Text;

    begin
        exit('My Home address \ Denmark 2800')
    end;
}

enum 50200 SendTo
{
    Extensible = true;

    value(0; Company)
    {
    }

    value(1; Private)
    {
    }
}

page 50200 MyAddressPage
{

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()

                var
                    iAddressProvider: Interface IAddressProvider;

                begin
                    AddressproviderFactory(iAddressProvider);
                    Message(iAddressProvider.GetAddress());
                end;

            }

            action(SendToHome)
            {
                ApplicationArea = All;

                trigger OnAction()

                begin
                    sendTo := sendTo::Private
                end;
            }

            action(SendToWork)
            {
                ApplicationArea = All;

                trigger OnAction()

                begin
                    sendTo := sendTo::Company
                end;
            }
        }
    }

    local procedure AddressproviderFactory(var iAddressProvider: Interface IAddressProvider)
    var
        CompanyImplementer: Codeunit CompanyAddressProvider;
        PrivateImplementer: Codeunit PrivateAddressProvider;
    begin

        if sendTo = sendTo::Company then
            iAddressProvider := CompanyImplementer;

        if sendTo = sendTo::Private then
            iAddressProvider := PrivateImplementer;

    end;

    var
        sendTo: enum SendTo;
   }
