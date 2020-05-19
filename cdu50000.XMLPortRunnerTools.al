codeunit 50000 "DTM - Management"
{
    // Version BCGOLIVE -- DELETE TABLES FOR GO-LIVE (TRANSACTIONAL,ASSIGN YOUR TABLES)
    Permissions = TableData "Item Ledger Entry" = rimd, TableData "Value Entry" = rimd,
    TableData "Warehouse Entry" = rimd,
    TableData "G/L Entry" = rimd, TableData "Cust. Ledger Entry" = rimd,
    TableData "Vendor Ledger Entry" = rimd, TableData "Item Vendor" = rimd,
    TableData "G/L Register" = rimd,
    TableData "Sales Shipment Header" = rimd, TableData "Sales Shipment Line" = rimd,
    TableData "Sales Invoice Header" = rimd, TableData "Sales Invoice Line" = rimd,
    TableData "Sales Cr.Memo Header" = rimd, TableData "Sales Cr.Memo Line" = rimd,
    TableData "Purch. Rcpt. Header" = rimd, TableData "Purch. Rcpt. Line" = rimd,
    TableData "Purch. Inv. Header" = rimd, TableData "Purch. Inv. Line" = rimd,
    TableData "Purch. Cr. Memo Hdr." = rimd, TableData "Purch. Cr. Memo Line" = rimd,
    TableData "Reservation Entry" = rimd, TableData "Entry Summary" = rimd,
    TableData "Detailed Cust. Ledg. Entry" = rimd, TableData "Detailed Vendor Ledg. Entry" = rimd,
    TableData "Deferral Header" = rimd, TableData "Deferral Line" = rimd,
    TableData "Production Order" = rimd, TableData "Prod. Order Line" = rimd,
    TableData "Prod. Order Component" = rimd, TableData "Prod. Order Routing Line" = rimd,
    TableData "Posted Deferral Header" = rimd, TableData "Posted Deferral Line" = rimd,
    TableData "Item Variant" = rimd, TableData "Unit of Measure Translation" = rimd,
    TableData "Item Unit of Measure" = rimd,
    TableData "Transfer Header" = rimd, TableData "Transfer Line" = rimd,
    TableData "Transfer Route" = rimd, TableData "Transfer Shipment Header" = rimd,
    TableData "Transfer Shipment Line" = rimd, TableData "Transfer Receipt Header" = rimd,
    TableData "Transfer Receipt Line" = rimd,
    TableData "Capacity Ledger Entry" = rimd, TableData "Lot No. Information" = rimd,
    TableData "Serial No. Information" = rimd, TableData "Item Entry Relation" = rimd,
    TableData "Return Shipment Header" = rimd, TableData "Return Shipment Line" = rimd,
    TableData "Return Receipt Header" = rimd, TableData "Return Receipt Line" = rimd,
    TableData "G/L Budget Entry" = rimd, TableData "Res. Capacity Entry" = rimd,
    TableData "Job Ledger Entry" = rimd, TableData "Res. Ledger Entry" = rimd,
    TableData "VAT Entry" = rimd, TableData "Document Entry" = rimd,
    TableData "Bank Account Ledger Entry" = rimd, TableData "Phys. Inventory Ledger Entry" = rimd,
    TableData "Approval Entry" = rimd, TableData "Posted Approval Entry" = rimd,
    TableData "Cost Entry" = rimd, TableData "Employee Ledger Entry" = rimd,
    TableData "Detailed Employee Ledger Entry" = rimd, TableData "FA Ledger Entry" = rimd,
    TableData "Maintenance Ledger Entry" = rimd, TableData "Service Ledger Entry" = rimd,
    TableData "Warranty Ledger Entry" = rimd, TableData "Item Budget Entry" = rimd,
    TableData "Production Forecast Entry" = rimd, TableData "Location" = rimd, TableData "Bin" = rimd,
    TableData "Customer" = rimd, TableData "Vendor" = rimd, TableData "Item" = rimd,
    TableData "Sales Header" = rimd,
    TableData "Sales Line" = rimd,
    TableData "Purchase Header" = rimd,
    TableData "Purchase Line" = rimd,
    TableData "Purch. Comment Line" = rimd,
    TableData "Sales Comment Line" = rimd,
    TableData "Item Register" = rimd,
    TableData "Comment Line" = rimd,
    TableData "Tracking Specification" = rimd,
    TableData "Item Application Entry" = rimd,
    TableData "Dimension Set Entry" = rimd,
    TableData "Prod. Order Comment Line" = rimd,
    TableData "Item Cross Reference" = rimd,
    TableData "Warehouse Request" = rimd,
    TableData "Warehouse Activity Header" = rimd,
    TableData "Warehouse Activity Line" = rimd,
    TableData "Warehouse Comment Line" = rimd,
    TableData "Registered Whse. Activity Hdr." = rimd,
    TableData "Registered Whse. Activity Line" = rimd,
    TableData "Item Tracking Comment" = rimd,
    TableData "Value Entry Relation" = rimd,
    TableData "Whse. Item Entry Relation" = rimd,
    TableData "Whse. Item Tracking Line" = rimd,
    TableData "Bin Content" = rimd,
    TableData "Warehouse Register" = rimd,
    TableData "Warehouse Receipt Header" = rimd,
    TableData "Warehouse Receipt Line" = rimd,
    TableData "Posted Whse. Receipt Header" = rimd,
    TableData "Posted Whse. Receipt Line" = rimd,
    TableData "Warehouse Shipment Header" = rimd,
    TableData "Warehouse Shipment Line" = rimd,
    TableData "Posted Whse. Shipment Header" = rimd,
    TableData "Posted Whse. Shipment Line" = rimd,
    TableData "Whse. Put-away Request" = rimd,
    TableData "Whse. Pick Request" = rimd,
    TableData "Computed Withholding Tax" = rimd,
    TableData "Computed Contribution" = rimd,
    TableData "VAT Book Entry" = rimd,
    TableData "GL Book Entry" = rimd,
    TableData "Posted Payment Lines" = rimd;
    //... ADD COUNTRY LOCALIZATION TABLES, FA, SERVICE etc. etc.


    trigger OnRun()
    begin
    end;

    var
        Text0001: Label 'Delete Records?';
        Text0002: Label 'Deleting Records!\Table: #1#######';

    procedure DeleteRecords()
    var
        Window: Dialog;
        RecRef: RecordRef;
        RecordDeletionTable: Record "DTM - Record Deletion Table";
    begin
        if not Confirm(Text0001, false) then
            exit;

        Window.Open(Text0002);

        if RecordDeletionTable.FindSet then
            repeat
                Window.Update(1, Format(RecordDeletionTable."Table ID"));
                RecRef.Open(RecordDeletionTable."Table ID");
                RecRef.DeleteAll;  //** DELETE DATA FROM TABLES
                RecRef.Close;
            until RecordDeletionTable.Next = 0;

        Window.Close;
    end;

    procedure InsertXMLRunnerLOG(parTable: Integer; parText: text[100])
    var
        tblXMLLOG: Record "DTM - XML Runner LOG Table";
        i: Integer;

    begin
        tblXMLLOG.Reset();
        IF tblXMLLOG.FINDLAST then
            i := tblXMLLOG.KeyTbl + 1
        else
            i := 1;

        tblXMLLOG.Reset;
        tblXMLLOG.Init();
        tblXMLLOG.KeyTbl := i;
        tblXMLLOG."Table ID" := parTable;
        tblXMLLOG."Migration Text" := parText;
        tblXMLLOG.Insert();
        Commit();
    end;


    procedure DeleteXMLRunnerLOG(parTable: Integer)
    var
        tblXMLLOG: Record "DTM - Record Deletion Table";
        i: Integer;

    begin
        tblXMLLOG.Reset();
        tblXMLLOG.SetRange("Table ID", parTable);
        tblXMLLOG.DeleteAll();
        Commit();
    end;

}