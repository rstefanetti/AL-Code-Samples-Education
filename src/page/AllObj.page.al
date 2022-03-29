page 50088 "AllObj"
{
    ApplicationArea = All;
    Caption = 'AllObj';
    PageType = List;
    SourceTable = "AllObj";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the Object ID field.';
                    ApplicationArea = All;
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the Object Name field.';
                    ApplicationArea = All;
                }

                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
