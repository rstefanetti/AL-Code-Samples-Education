page 50131 Meteo
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            usercontrol(MeteoJs; MeteoAddin)
            {
                ApplicationArea = All;

                trigger controlAddinReady()
                begin

                end;
            }
        }
    }

}

