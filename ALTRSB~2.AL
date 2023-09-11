page 50001 AltRSBankAccounts
{

    ApplicationArea = All;
    Caption = 'AltRSBankAccounts';
    PageType = List;
    SourceTable = "Bank Account";
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /// STANDARD FIELDS
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Code';
                    ToolTip = 'Bank Code';
                    Editable = true;
                    Visible = true;
                    Enabled = true;
                }

                // NEW FIELD ****
                field(AltRSClosed; AltRSClosed)
                {
                    ApplicationArea = All;
                    Caption = 'AltRSClosed';
                    ToolTip = 'AltRSClosed';
                    Editable = true;
                    Visible = true;
                    Enabled = true;
                }

            }
        }
    }
}
