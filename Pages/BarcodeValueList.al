page 50127 BarcodePicturesLists
{
    PageType = ListPlus;
    SourceTable = Barcode;
    CaptionML = ENU = 'Barcode Pictures List', ITA = 'Barcode Immagini lista';
    UsageCategory = Documents;
    ApplicationArea = All;

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