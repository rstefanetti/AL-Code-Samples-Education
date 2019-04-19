page 50195 "Lot Inventory at Date"
{
    PageType = List;
    SourceTable = "Warehouse Entry";
    SourceTableTemporary = true;
    UsageCategory = Administration;
    ApplicationArea = all;

    Caption = 'Lot Inventory at Date';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Descrizione; recItem.Description + recItem."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Item Descrption';
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Registering Date"; "Registering Date")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT recItem.GET("Item No.") THEN CLEAR(recItem);
    end;

    trigger OnOpenPage()
    begin
        SetPageData;
    end;

    var
        LotInventory: Query "Lot Inventory at Date"; //DEFINE QUERY
        ContaRiga: Integer;
        recItem: Record "Item";

    local procedure SetPageData()
    begin
        LotInventory.OPEN;  //OPEN QUERY
        WHILE LotInventory.READ DO BEGIN
            ContaRiga += 1;
            "Entry No." := ContaRiga;
            "Item No." := LotInventory.Articolo;
            "Lot No." := LotInventory.Lotto;
            "Location Code" := LotInventory.Magazzino;
            "Bin Code" := LotInventory.Collocazione;
            "Registering Date" := LotInventory.Data;
            Quantity := LotInventory.Giacenza;
            IF Quantity <> 0 THEN
                INSERT;
        END;
        FINDFIRST;
    end;
}

