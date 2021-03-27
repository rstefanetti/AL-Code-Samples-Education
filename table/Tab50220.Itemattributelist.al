table 50220 "Item attribute list"
{
    Caption = 'Item attribute list';
    DataClassification = ToBeClassified;
    TableType = Temporary;
    fields
    {
        field(10; "No."; code[20])
        {
            Caption = 'Item no.';
            DataClassification = ToBeClassified;
        }
        field(20; Description; text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(30; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
        }
        field(40; "Item Attribute ID"; Integer)
        {
            Caption = 'Item Attribute ID';
            DataClassification = ToBeClassified;
        }
        field(50; "Item Attribute Value ID"; integer)
        {
            Caption = 'Item Attribute Value ID';
            DataClassification = ToBeClassified;
        }
        field(60; Name; text[250])
        {
            Caption = 'Attribute Name';
            DataClassification = ToBeClassified;
        }
        field(70; Value; text[250])
        {
            Caption = 'Attribute Value';
            DataClassification = ToBeClassified;
        }
        field(80; "Numeric Value"; Decimal)
        {
            Caption = 'Attribute numeric Value';
            DataClassification = ToBeClassified;
        }
        field(90; "Date Value"; Date)
        {
            Caption = 'Date Value';
            DataClassification = ToBeClassified;
        }
        field(100; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", Name,Value)
        {
            Clustered = true;
        }
    }

}
