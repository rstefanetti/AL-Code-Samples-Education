page 50130 Exchange
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;


    layout
    {
        area(Content)
        {
            usercontrol(Exchange; ExchangeAddin)
            {
                ApplicationArea = All;

                trigger controlAddinReady()
                begin

                end;
            }
        }
    }
}

