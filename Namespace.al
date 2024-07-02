namespace MyNamespace;
using SomeOtherNamespace;

codeunit 10 MyCode
{
    ...
}


#example
namespace Fredborg.Custom.Item;

table 50100 Item
{
    Caption = 'Item';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Link to Std Item"; Code[20])
        {
            Caption = 'Link to Std Item';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}

namespace Fredborg.Custom.Item;

using Microsoft.Sales.Customer;

table 50100 Item
{
    Caption = 'Item';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Link to Std Item"; Code[20])
        {
            Caption = 'Link to Std Item';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(4; "Customer Link"; Code[20])
        {
            Caption = 'Customer Link';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}

trigger OnInsert()
    var
        SalesHeader: Record Microsoft.Sales.Document."Sales Header";
        SalesLine: Record Microsoft.Sales.Document."Sales Line";
    begin
        SalesHeader.FindFirst();
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine."No." := Rec."No.";
        SalesLine.Insert();
    end;

