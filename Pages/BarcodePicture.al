page 50123 BarcodePicture
{
    PageType = CardPart;
    SourceTable = Barcode;
    CaptionML = ENU = 'Barcode', ITA = 'Barcode';
    //UsageCategory = Documents;
    //ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(Picture; Picture)
            {
                ApplicationArea = All;
                Editable = false;
                ShowCaption = false;
            }
        }
    }
}