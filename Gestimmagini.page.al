page 61105 Gest_immagini
{

    ApplicationArea = All;
    Caption = 'Gestione immagini';
    PageType = List;
    SourceTable = table_Images;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'tabella immmagini';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Image; Rec.Image)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
