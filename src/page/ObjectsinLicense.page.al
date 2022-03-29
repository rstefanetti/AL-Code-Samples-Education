page 50094 "Objects in License"
{
    ApplicationArea = All;
    Caption = 'Objects in License';
    PageType = List;
    SourceTable = "Temp Objects in License";
    UsageCategory = Lists;
    Editable = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("id oggetto"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the id oggetto field.';
                    ApplicationArea = All;
                }
                field("nome oggetto"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the nome oggetto field.';
                    ApplicationArea = All;
                }
                field("tipo oggetto"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the tipo oggetto field.';
                    ApplicationArea = All;
                }
                field(usato; Rec.Used)
                {
                    ToolTip = 'Specifies the value of the usato field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
