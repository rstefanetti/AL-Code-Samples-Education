
/// ROLE CENTER EXTENSION - BUSINESS MANAGER ROLE CENTER
pageextension 50135 roleCenterExt extends "Business Manager Role Center"
{

    layout
    {
        addafter(Control9)
        {
            part(MeteoPart; Meteo)       //ADD Meteo Part
            {
                ApplicationArea = All;

            }
            part(StocksPart; Stocks)      //ADD Stock Part
            {
                ApplicationArea = All;

            }
            part(ExchangePart; Exchange)    //ADD Exchange Part
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
        
    }

    var
        myInt: Integer;
}