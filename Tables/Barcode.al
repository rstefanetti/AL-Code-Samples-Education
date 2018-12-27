table 50121 Barcode
{

    fields
    {
        field(1; PrimaryKey; Guid)
        {
            CaptionML = ENU = 'Primary Key';
        }
        field(2; Value; Text[250])
        {
            CaptionML = ENU = 'Value';
        }
        field(3; Type; Option)
        {
            CaptionML = ENU = 'Type';
            OptionMembers = " ",c39,c128a,c128b,c128c,i2of5,qr;
            OptionCaptionML = ENU = 'Select a Type,Code 39,Code 128a,Code 128b,Code 128c,2 of 5 Interleaved,QR Code';
        }
        field(4; Width; Integer)
        {
            CaptionML = ENU = 'Width';
            InitValue = 250;
        }
        field(5; Height; Integer)
        {
            CaptionML = ENU = 'Height';
            InitValue = 100;
        }
        field(6; IncludeText; Boolean)
        {
            CaptionML = ENU = 'Include Text';
        }
        field(7; Border; Boolean)
        {
            CaptionML = ENU = 'Border';
        }
        field(8; ReverseColors; Boolean)
        {
            CaptionML = ENU = 'Reverse Colors';
        }
        field(9; ECCLevel; Option)
        {
            CaptionML = ENU = 'ECC Level';
            OptionMembers = "0","1","2","3";
            OptionCaptionML = ENU = 'Low (L),Medium-Low (M),Medium-High (Q),High (H)';
        }
        field(10; Size; Option)
        {
            CaptionML = ENU = 'Size';
            OptionMembers = "1","2","3","4","5","6","7","8","9","10";
            OptionCaptionML = ENU = '21x21,42x42,63x63,84x84,105x105,126x126,147x147,168x168,189x189,210x210';
            InitValue = "5";
        }
        field(11; PictureType; Option)
        {
            CaptionML = ENU = 'Picture Type';
            OptionMembers = png,gif,jpg;
            OptionCaptionML = ENU = 'png,gif,jpg';
        }
        field(12; Picture; Media)
        {
            CaptionML = ENU = 'Picture';
        }

    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = false;
        }
    }

    trigger OnInsert();
    begin
        PrimaryKey := CreateGuid;
        GenerateBarcode();
    end;

    trigger OnModify();
    begin
        GenerateBarcode();
    end;

    procedure GenerateBarcode()
    var
        GenerateBarcodeCode: Codeunit GenerateBarcode;
    begin
        GenerateBarcodeCode.GenerateBarcode(Rec);
    end;

}

