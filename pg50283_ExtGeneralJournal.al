pageextension 50283 PageExtension50283 extends "General Journal"
{ //ADD FIELDS HIDDEN TO PAGE GENERAL JOURNAL
    layout
    {
        modify(Control1)
        {
            FreezeColumn = "Posting Group";
        }
        addafter("Service Tariff No.")
        {
            field("Posting Group"; "Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Activity Code")
        {
            field("Reason Code_Custom"; "Reason Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document No.")
        {
            field("Account Type_Custom"; "Account Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Refers to Period")
        {
            field("Document Type_Custom"; "Document Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Account No.")
        {
            field("Document No._Custom"; "Document No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("Posting Date_Custom"; "Posting Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Credit Amount")
        {
            field(Amount_Custom; Amount)
            {
                ApplicationArea = All;
            }
            field("VAT Amount_Custom"; "VAT Amount")
            {
                ApplicationArea = All;
            }
            field("VAT Posting_Custom"; "VAT Posting")
            {
                ApplicationArea = All;
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("Gen. Posting Type_Custom"; "Gen. Posting Type")
            {
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group_Custom"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group_Custom"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Bal. Account Type_Custom"; "Bal. Account Type")
            {
                ApplicationArea = All;
            }
            field("Bal. Account No._Custom"; "Bal. Account No.")
            {
                ApplicationArea = All;
            }
            field("Bal. Gen. Posting Type_Custom"; "Bal. Gen. Posting Type")
            {
                ApplicationArea = All;
            }
            field("Posting Group_Custom"; "Posting Group")
            {
                ApplicationArea = All;
            }

        }
    }
}
