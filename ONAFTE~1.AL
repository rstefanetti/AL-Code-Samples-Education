codeunit 53012 OnAfterPostSales
{

    //Automatic
    EventSubscriberInstance = StaticAutomatic;


    // *** EVENT SUBSCRIBING - SALES POST - OnAfterPostSalesDoc ***
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    local procedure "Sales-Post_OnAfterPostSalesDoc"
    (
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";

        //Documents posted
        SalesShptHdrNo: Code[20];
        RetRcpHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        //Documents posted

        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        WhseReceiv: Boolean;
        PreviewMode: Boolean
    )

    begin

        //  ** inserire procedure qua **
        Message(SalesShptHdrNo);      // Numn doc registrata --> output Spedizione Registrata
        Message(SalesInvHdrNo);       // Numn doc registrata --> output SaleInvoiceNo
        Message(SalesCrMemoHdrNo);    // Numn doc registrata --> output SalesCreditMemo
        Message(RetRcpHdrNo);         // Numn doc registrata --> output ReceiptHeaderNo


        // ** ON AFTER POST SALES INVOICE **

        // ***  AUTOMATION ***

        // CREATE AND SAVE PDF

        // CREATE ATTACHMENTS PDF EMBEDDED

        // PRINT NATIVE BARCODE

        // SEND EMAIL

        // ** CALL AZURE FUNCTION AFTER POSTING **
        // NATIVE MODULES
        /* The new module contains three (public) codeunits

        Azure Functions (codeunit 7804)
        Azure Functions Authentication (codeunit 7800)
        Azure Functions Response (codeunit 7805) 
        */


        //CALL AZURE FUNCTION
        IF SalesInvHdrNo <> '' THEN BEGIN

            //CALL AZURE FUNCTION

        END;

        // ***  AUTOMATION ***

    end;


    //VAR
    var
        myInt: Integer;
}