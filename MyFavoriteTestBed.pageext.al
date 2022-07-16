pageextension 50132 MyFavoriteTestBed extends "Customer List"
{
    trigger OnOpenPage();
    var
        ReturnOfTheComplexType: codeunit ReturnOfTheComplexType;
    begin
        ReturnOfTheComplexType.Test();
    end;
}
