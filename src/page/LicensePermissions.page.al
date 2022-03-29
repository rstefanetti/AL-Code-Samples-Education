page 50077 "License Permissions"
{
    ApplicationArea = All;
    Caption = 'License Permissions';
    PageType = List;
    SourceTable = "License Permission";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Number"; Rec."Object Number")
                {
                    //ToolTip = 'Specifies the value of the Object Number field.';
                    ApplicationArea = All;
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                    ApplicationArea = All;
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ToolTip = 'Specifies the value of the Read Permission field.';
                    ApplicationArea = All;
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ToolTip = 'Specifies the value of the Modify Permission field.';
                    ApplicationArea = All;
                }
                field("Limited Usage Permission"; Rec."Limited Usage Permission")
                {
                    ToolTip = 'Specifies the value of the Limited Usage Permission field.';
                    ApplicationArea = All;
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ToolTip = 'Specifies the value of the Insert Permission field.';
                    ApplicationArea = All;
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ToolTip = 'Specifies the value of the Execute Permission field.';
                    ApplicationArea = All;
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ToolTip = 'Specifies the value of the Delete Permission field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
