report 50000 "tst barcode cloud"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Customer Barcodes';
    RDLCLayout = '.\Reportlayout\CustomerBarcodes.rdl';
    //WordLayout = '.\Reportlayout\CustomerBarcodes.docx';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Customer';

            column(Name; Name)
            {
            }

            column(Barcode; EncodedText)
            {
            }


            trigger OnAfterGetRecord()
            var

                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";                       //BARCODE SIMBOLOGY DECLARATION
                BarcodeStr: Code[20];

            begin

                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;         //FONT PROVIDER IDAUTOMATION
                BarcodeSymbology := Enum::"Barcode Symbology"::Code39;                        //SIMBOLOGY - "CODE 39" in this case
                BarcodeStr := "No.";                                                               
                BarcodeFontProvider.ValidateInput(BarcodeStr, BarcodeSymbology);              //VALIDATE INPUT DATA - NOT MANDATORY
                EncodedText := BarcodeFontProvider.EncodeFont(BarcodeStr, BarcodeSymbology);  //ENCODETEXT in Barcode

            end;
        }
    }

    var
        EncodedText: Text;
}

