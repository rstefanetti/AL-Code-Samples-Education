enum 50121 Loyalty
{
    Extensible = true;
    
    value(0; None) { }
    value(1; Bronze) { }
    value(2; Silver) { }
    value(3; Gold)
    {
        Caption = 'Gold Customer';
    }
}


enumextension 50130 LoyaltyWithDiamonds extends Loyalty
{
    value(50130; Diamond)
    {
        Caption = 'Diamond Level';
    }
}


field(50100; Loyal; enum Loyalty) {}

var
    LoyaltyLevel: enum Loyalty;

codeunit 50140 EnumUsage
{
    procedure Foo(p: enum Loyalty)
    var
        LoyaltyLevel: enum Loyalty;
    begin
        if p = p::Gold then begin
            LoyaltyLevel := p;
        end;
    end;
}


------------------------------------------

enumextension 50133 TypeEnumExt extends TypeEnum
{
    value(10; Resource) { }
}

tableextension 50135 TableWithRelationExt extends TableWithRelation
{
    fields
    {
        modify(Relation)
        {
            TableRelation = if (Type = const (Resource)) Resource;
        }
    }
}

page 50133 PageOnRelationTable
{
    SourceTable = TableWithRelation;
    SourceTableView = where (Type = const (Resource));
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(MyRep)
            {
                field(Id; Id)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Relation; Relation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}



