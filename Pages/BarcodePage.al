page 50122 BarcodeCard
{
    PageType = Card;
    SourceTable = Barcode;
    CaptionML = ENU = 'Barcode Card', ITA = 'Barcode';
    DataCaptionExpression = Value;
    //UsageCategory = Documents;
    //ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', ITA = 'Generale';
                field(Value; Value) { ApplicationArea = All; }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(PictureType; PictureType) { ApplicationArea = All; }
            }
            group(Options)
            {
                CaptionML = ENU = 'Options', ITA = 'Opzioni';
                group(Barcode)
                {
                    Visible = Type <> Type::QR;
                    field(Width; Width) { ApplicationArea = All; }
                    field(Height; Height) { ApplicationArea = All; }
                    field(IncludeText; IncludeText) { ApplicationArea = All; }
                    field(Border; Border) { ApplicationArea = All; }
                    field(ReverseColors; ReverseColors) { ApplicationArea = All; }
                }
                group(QRCode)
                {
                    Visible = Type = Type::QR;
                    field(ECCLevel; ECCLevel) { ApplicationArea = All; }
                    field(Size; Size) { ApplicationArea = All; }
                }
            }
        }
        area(FactBoxes)
        {
            part(BarcodePicture; BarcodePicture)
            {
                ApplicationArea = All;
                SubPageLink = PrimaryKey = field (PrimaryKey);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GenerateBarcode)
            {
                CaptionML = ENU = 'Generate Barcode', ITA = 'Creazione Barcode';
                Image = BarCode;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    GenerateBarcode;
                end;
            }
        }
    }

    var
        myInt: Integer;
}