page 50100 test_WS_SOAP
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Test WS SOAP - httpClient';

    layout
    {
        area(Content)
        {
            /* repeater(GroupName)
            {
                field(Name; NameSource)
                {
                    
                }
            } */
        }
    }

    actions
    {
        area(Processing)
        {
            action("Test SOAP WS Connection")
            {
                ApplicationArea = All;
                Caption = 'Test SOAP WS Connection';
                Image = LaunchWeb;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    WS_SOAP_Handling: Codeunit "WS_SOAP_Handling";

                begin
                    WS_SOAP_Handling.LoadXMLandCallWS();
                end;
            }
        }
    }

}
