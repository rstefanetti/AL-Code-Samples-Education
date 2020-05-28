page 50010 TestPageWithAddIn
{
    Caption = 'Test Page With AddIn';

    PageType = List;
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(Content)
        {
            // The control add-in can be placed on the page using usercontrol keyword.
            usercontrol(ControlName; SampleAddIn)
            {

                ApplicationArea = All;

                // The control add-in events can be handled by defining a trigger with a corresponding name.
                trigger Callback(i: integer; s: text; d: decimal; c: char)
                begin
                    Message('Got from js: %1, %2, %3, %4', i, s, d, c);
                end;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(CallJavaScript)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    // The control add-in methods can be invoked via a reference to the usercontrol.
                    CurrPage.ControlName.CallJavaScript(5, '*** TEST ON-ACTION *** ', 6.3, 'c');
                end;
            }
        }
    }
}