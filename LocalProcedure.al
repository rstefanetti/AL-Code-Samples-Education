local procedure MyProcedure(Customer: Record Customer; Int: Integer)
begin
end;

// space

local procedure MyProcedure2(Customer: Record Customer; Int: Integer)
begin
end;


MyProcedure();
MyProcedure(1);
MyProcedure(1, 2);


var
    Number: Integer;

local procedure MyProcedure(a: Integer; b: Integer): Integer
