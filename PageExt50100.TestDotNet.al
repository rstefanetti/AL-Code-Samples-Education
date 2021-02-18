pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        //TEST DOTNET DATETIME
        now: DotNet MyDateTime;

        WSDotNet: DotNet env;
        testo: text;
    begin
        now := now.UtcNow();

        testo := WSDotNeT.Version.ToString();
        Message('Version: ' + testo);
    end;
}



