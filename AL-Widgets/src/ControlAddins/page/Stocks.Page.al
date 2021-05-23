page 50132 Stocks
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            usercontrol(Stocks; StocksAddin)
            {
                ApplicationArea = All;

                trigger controlAddinReady()
                begin

                end;
            }
        }
    }
}


