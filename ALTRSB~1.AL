tableextension 50001 "AltRSBank Account" extends "Bank Account"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "AltRSClosed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(50101; "AltRSClosedReason"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }

    }
   
}