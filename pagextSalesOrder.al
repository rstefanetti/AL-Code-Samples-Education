pageextension 50100 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field(Total; Total)
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
    }

    var
        Total: Text;
        WaitTaskId: Integer;

    trigger OnAfterGetRecord()
    var
        //Defines a variable for passing parameters to the background task
        TaskParameters: Dictionary of [Text, Text];
    begin
        TaskParameters.Add('Wait', '1000');
        //TaskID, CodeunitId, Parameters, Timeout, ErrorLevel
        CurrPage.EnqueueBackgroundTask(WaitTaskId, 50100, TaskParameters, 1000, PageBackgroundTaskErrorLevel::Error);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    begin
        if (TaskId = WaitTaskId) then begin
            Total := Results.Get('Total');
        end;
    end;
}
