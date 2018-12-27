page 50121 BarcodeList
{
    PageType = List;
    SourceTable = Barcode;
    CaptionML = ENU = 'Barcode List', ITA = 'Barcode';
    CardPageId = BarcodeCard;
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Value; Value)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Width; Width)
                {
                    ApplicationArea = All;
                }
                field(Height; Height)
                {
                    ApplicationArea = All;
                }
                field(IncludeText; IncludeText)
                {
                    ApplicationArea = All;
                }
                field(Border; Border)
                {
                    ApplicationArea = All;
                }
                field(ReverseColors; ReverseColors)
                {
                    ApplicationArea = All;
                }
                field(ECCLevel; ECCLevel)
                {
                    ApplicationArea = All;
                }
                field(Size; Size)
                {
                    ApplicationArea = All;
                }
                field(PictureType; PictureType)
                { ApplicationArea = All; }
                field(Picture; Picture)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}