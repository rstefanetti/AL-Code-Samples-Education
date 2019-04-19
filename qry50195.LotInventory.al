query 50195 "Lot Inventory at Date"
{
    Caption = 'Lot Inventory at Date';
    OrderBy = Ascending (Articolo), Ascending (Lotto), Ascending (Magazzino), Ascending (Collocazione), Ascending (Data);

    elements
    {
        dataitem(Warehouse_Entry; "Warehouse Entry")
        {
            column(Articolo; "Item No.")
            {
            }
            column(Lotto; "Lot No.")
            {
            }
            column(Magazzino; "Location Code")
            {
            }
            column(Collocazione; "Bin Code")
            {
            }
            column(Data; "Registering Date")
            {
            }
            column(Giacenza; Quantity)
            {
                Method = Sum;
            }
        }
    }
}

