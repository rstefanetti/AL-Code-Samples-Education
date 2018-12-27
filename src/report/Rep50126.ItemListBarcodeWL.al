report 50126 "ItemListBarcodeWL"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = Word;
    // RDLCLayout = 'ItemListBarcode.rdl';
    WordLayout = 'Layout\Barcode.docx';



    dataset
    {

        dataitem(DataItemName; Barcode)

        {

            column(Value; Value)
            {

            }

            column(Type; Type)
            {

            }

            column(Picture; Picture)
            {

            }
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
        GenerateBarcodeCode: Codeunit GenerateBarcode;
        BarcodeCalc: Text;

}