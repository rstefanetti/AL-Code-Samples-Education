page 50101 "SOAP Test Page"
{
    PageType = Card;
    Caption = 'Test WS SOAP - DOM XML';
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(processing)
        {
            action("Create Soap Message")
            {
                Caption = 'Create Soap Message';
                ApplicationArea = All;
                Image = XMLFile;

                trigger OnAction()
                var
                    XML: Codeunit "SOAP Document";
                begin
                    XML.CreateSoapMessage;
                end;
            }
        }
    }
}
