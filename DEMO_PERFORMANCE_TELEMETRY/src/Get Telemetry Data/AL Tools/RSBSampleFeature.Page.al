page 53517 "RSB Sample Feature"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Sample Feature';  //ERREA CASE

    layout
    {
        area(Content)
        {
            group(Information)
            {
                InstructionalText = 'This sample page allows you to test Feature Telemetry. If application insights connection string in app.json is filled in, running the Emit feature telemetry action will emit telemetry to you app insights account.';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(EmitFeatureTelemetry)
            {
                ApplicationArea = All;
                Caption = 'Emit feature telemetry';
                ToolTip = 'Running this action will emit telemetry to your application insights account. Notice all the extra common custom dimensions that are present for telemetry messages emitted by Feature Telemetry codeunit.';

                trigger OnAction()
                var
                    FeatureTelemetry: Codeunit "Feature Telemetry";
                begin
                    // ERREA FEATURE TELEMETRY
                    FeatureTelemetry.LogUsage('0000ERREA', 'Sample feature', 'Run processing');  //ERREA CASE
                end;
            }
        }
    }

}