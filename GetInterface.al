   procedure GetInterface(var Loyalty: Interface ILoyaltyLevel);
    begin
        // Here be dragons
    end;

    procedure Consumer();
    var
        Loyalty: Interface ILoyaltyLevel;
    begin
        GetInterface(Loyalty);
        Loyalty.GetTreatment();
    end;
