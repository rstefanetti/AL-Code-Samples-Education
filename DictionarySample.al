trigger OnRun()
    var
        dict1: Dictionary of [Integer, Integer];
        dict2: Dictionary of [Integer, Integer];
        dictionaryKey: Integer;
    begin
        // ...
        foreach dictionaryKey in dict1.Keys() do
            dict2.Add(dictionaryKey, dict1.Get(dictionaryKey));
    end;


procedure CountCharactersInCustomerName(customerName: Text; counter: Dictionary of [Char, Integer])
var
    i : Integer;
    c : Integer;
begin
    for i := 1 to StrLen(customerName) do
        if counter.Get(customerName[i], c) then
            counter.Set(customerName[i], c + 1)
        else
            counter.Add(customerName[i], 1);
end;


** to read
https://businesscentralgeek.com/how-to-use-a-dictionary-in-business-central
