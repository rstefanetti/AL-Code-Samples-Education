codeunit 50100 MyPageBackgroundTask
{
    trigger OnRun()
    var
        Result: Dictionary of [Text, Text];
        SalesLine: Record "Sales Line";
        Total: Decimal;
    begin

        // Run some code
        if SalesLine.FindSet() then
            repeat
                Total := Total + SalesLine.Amount;
            until SalesLine.Next() = 0;

        Result.Add('Total', format(Total));

        Page.SetBackgroundTaskResult(Result);
    end;

}
