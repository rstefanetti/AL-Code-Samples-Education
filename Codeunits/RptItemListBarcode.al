report 50125 ItemListBarcode
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ItemListBarcode.rdl';


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