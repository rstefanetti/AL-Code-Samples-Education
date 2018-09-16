// RS -  BC Go-live Tool v.2.0.0.6 - 20180915
// Based on Original release of Olof Simren -  Go-Live Tool, Range 50101..
page 50101 "Record Deletion"
{
    // version BCGOLIVE
    InsertAllowed = True; //Add records
    PageType = List;
    Editable = True;
    SourceTable = "Record Deletion Table";
    UsageCategory = Tasks;  //show in the Search Menù - "Record Deletion page"
    //AccessByPermission = page "Record Deletion" = X;  //permissions for Page
    AccessByPermission = tabledata "Record Deletion Table" = RIMD; //ALL permissions for Table
    ApplicationArea = All;
    CaptionML = ENU = 'Record Deletion';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Table ID';
                    ToolTip = 'Insert table no. to Delete';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("START DELETE RECORDS")
            {
                CaptionML = ENU = 'START DELETE RECORDS';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RecordDeletionMgt: Codeunit "Record Deletion Mgt.";
                begin
                    RecordDeletionMgt.DeleteRecords; //START DELETE RECORDS
                end;

            }
        }
    }
}

table 50101 "Record Deletion Table"
{
    // version BCGOLIVE
    fields
    {
        field(1; "Table ID"; Integer)
        {
            Editable = true;  //INSERT TABLE No.
        }
        field(5; "Delete Records"; Boolean)
        {
        }
        field(6; Company; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Company := CompanyName;
    end;
}

codeunit 50101 "Record Deletion Mgt."
{
    // Version BCGOLIVE -- DELETE TABLES FOR GO-LIVE (TRANSACTIONAL,ASSIGN YOUR TABLES)
    Permissions = TableData "Item Ledger Entry" = rimd, TableData "Value Entry" = rimd,
    TableData "G/L Entry" = rimd, TableData "Cust. Ledger Entry" = rimd,
    TableData "Vendor Ledger Entry" = rimd, TableData "Item Vendor" = rimd,
    TableData "G/L Register" = rimd, TableData "Item Register" = rimd,
    TableData "Sales Shipment Header" = rimd, TableData "Sales Shipment Line" = rimd,
    TableData "Sales Invoice Header" = rimd, TableData "Sales Invoice Line" = rimd,
    TableData "Sales Cr.Memo Header" = rimd, TableData "Sales Cr.Memo Line" = rimd,
    TableData "Purch. Rcpt. Header" = rimd, TableData "Purch. Rcpt. Line" = rimd,
    TableData "Purch. Inv. Header" = rimd, TableData "Purch. Inv. Line" = rimd,
    TableData "Purch. Cr. Memo Hdr." = rimd, TableData "Purch. Cr. Memo Line" = rimd,
    TableData "Reservation Entry" = rimd, TableData "Entry Summary" = rimd,
    TableData "Detailed Cust. Ledg. Entry" = rimd, TableData "Detailed Vendor Ledg. Entry" = rimd,
    TableData "Deferral Header" = rimd, TableData "Deferral Line" = rimd,
    TableData "Item Application Entry" = rimd,
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
    TableData "Warehouse Entry" = rimd;
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
        RecordDeletionTable: Record "Record Deletion Table";
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
}