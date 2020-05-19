table 50001 "DTM - XML Runner LOG Table"
{
    // XMLPORT RUNNER LOG
    Caption = 'DTM - XML Runner LOG Table';
    
    fields
    {
        field(1; "KeyTbl"; Integer)
        {
            Editable = true;  
        }
        field(2; "Table ID"; Integer)
        {
            Editable = true;  
        }
        field(3; "Migration Text"; text[200])
        {
             Editable = true;  
        }       
    }

    keys
    {
        key(Key1; "KeyTbl")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        
    end;
}