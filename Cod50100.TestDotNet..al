//DOTNET DECLARATIONS
dotnet
{
    //MSCORLIB - SYSTEMDATETIME
    assembly(mscorlib)
    {
        type(System.DateTime; MyDateTime) { }   //DATETIME
        type(System.Environment; env) { }
        type(System.Reflection.Assembly; assembly) { }
        type(System.IO.Path; path) { }

    }

}

codeunit 50100 "Test DOTNET"
{

    trigger OnRun();
    begin
        message('TEST DONET');
    end;

}