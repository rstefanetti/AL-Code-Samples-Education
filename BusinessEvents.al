** business events samples **

enumextension 50161 MyExtEventCategory extends EventCategory

{

    value(50000; "My Accounts Receivable Events")
    {        
        Caption = 'My Accounts Receivable Events';
    }
    value(50001; "My Accounts Payable Events")
    {
        Caption = 'My Accounts Payable Events';
    }
    value(50002; "My Sales Events")
    {
        Caption = 'My Sales Events';
    }

    value(50003; "My Purchasing Events")
    {
        Caption = 'My Purchasing Events';
    }
}



Codeunit 51104 MyBusinessEvents
{
    var
        EventCategory: Enum EventCategory;
        CustomerBlockedTok: Text;


    // BUSINESS EVENTS

    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterValidateEvent', 'Blocked', false, false)]
    local procedure OnAfterValidateCustomerBlocked(var Rec: Record Customer)
    var
        Blocked: enum "Customer Blocked";
        Url: Text[250];
        CustomerApiUrlTok: Label 'v2.0/companies(%1)/customers(%2)', Locked = true;
    begin
        Url := GetBaseUrl() + StrSubstNo(CustomerApiUrlTok, GetCompanyId(), TrimId(Rec.SystemId));
        if Rec.Blocked <> Blocked::" " then
            MyBusinessEventCustomerBlocked(Rec.SystemId, Rec.Blocked, Url)
        else
            MyBusinessEventCustomerUnBlocked(Rec.SystemId, Rec.Blocked, Url);
    end;


    //EXTERNAL BUSINESS EVENTS - SALES
    [ExternalBusinessEvent('salesorderposted', 'Sales order posted', 'Triggered when sales order has been posted', EventCategory::"My Sales Events")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"Sales Header", 'R')] // optional
    procedure SalesOrderPosted(salesOrderId: Guid; customerName: Text[250]; orderNumber: Text[20])
    begin
    end;


    [ExternalBusinessEvent('CustomerBlocked', 'Customer blocked', 'This business event is triggered when a customer is blocked for shipping/invoicing.', EventCategory::"My Accounts Receivable Events")]
    local procedure MyBusinessEventCustomerBlocked(CustomerId: Guid; Blocked: enum "Customer Blocked"; Url: text[250])
    begin
    end;

    [ExternalBusinessEvent('CustomerUnBlocked', 'Customer unblocked', 'This business event is triggered when a customer is unblocked for shipping/invoicing.', EventCategory::"My Accounts Receivable Events")]
    local procedure MyBusinessEventCustomerUnBlocked(CustomerId: Guid; Blocked: enum "Customer Blocked"; Url: text[250])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePosting', '', true, true)]
    local procedure OnAfterFinalizePostingSalesInvoice
    (var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header";
     var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
     var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
     CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        Url: Text[250];
        SalesInvoiceApiUrlTok: Label 'v2.0/companies(%1)/salesInvoices(%2)', Locked = true;
        SalesCreditMemoApiUrlTok: Label 'v2.0/companies(%1)/salesCreditMemos(%2)', Locked = true;
        SalesShipmentApiUrlTok: Label 'v2.0/companies(%1)/salesShipments(%2)', Locked = true;
    begin
        if SalesInvoiceHeader."No." <> '' then begin
            Url := GetBaseUrl() + StrSubstNo(SalesInvoiceApiUrlTok, GetCompanyId(), TrimId(SalesInvoiceHeader.SystemId));
            MyBusinessEventSalesInvoicePosted(SalesInvoiceHeader.SystemId, Url);
        end;
        if SalesCrMemoHeader."No." <> '' then begin
            Url := GetBaseUrl() + StrSubstNo(SalesCreditMemoApiUrlTok, GetCompanyId(), TrimId(SalesCrMemoHeader.SystemId));
            MyBusinessEventSalesCreditMemoPosted(SalesCrMemoHeader.SystemId, Url);
        end;
        if SalesShipmentHeader."No." <> '' then begin
            Url := GetBaseUrl() + StrSubstNo(SalesShipmentApiUrlTok, GetCompanyId(), TrimId(SalesShipmentHeader.SystemId));
            MyBusinessEventSalesShipmentPosted(SalesShipmentHeader.SystemId, Url);
        end;
    end;

    //SUBSCRIBING TO EXTERNAL BUSINESS EVENT
    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnPostDocumentBeforeNavigateAfterPosting', '', true, true)]
    local procedure OnPostDocument(var SalesHeader: Record "Sales Header"; var PostingCodeunitID: Integer; var Navigate: Enum "Navigate After Posting"; DocumentIsPosted: Boolean; var IsHandled: Boolean)
    begin
        SalesOrderPosted(SalesHeader.SystemId, SalesHeader."Sell-to Customer Name", SalesHeader."No.");
    end;

    [ExternalBusinessEvent('SalesInvoicePosted', 'Sales invoice posted ', 'This business event is triggered when a sales invoice is posted as part of the Quote to Cash process.', EventCategory::"My Accounts Receivable Events")]
    local procedure MyBusinessEventSalesInvoicePosted(SalesInvoiceId: Guid; Url: text[250])
    begin
    end;

    [ExternalBusinessEvent('SalesCreditMemoPosted', 'Sales credit memo posted', 'This business event is triggered when a sales credit memo is posted.', EventCategory::"My Accounts Receivable Events")]
    local procedure MyBusinessEventSalesCreditMemoPosted(SalesCreditMemoId: Guid; Url: text[250])
    begin
    end;

    [ExternalBusinessEvent('SalesShipmentPosted', 'Sales shipment posted', 'This business event is triggered when goods from a sales order are shipped by the internal warehouse/external logistics company. This can trigger Finance Department to post a sales invoice.', EventCategory::"My Accounts Receivable Events")]
    local procedure MyBusinessEventSalesShipmentPosted(SalesShipmentId: Guid; Url: text[250])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterCustLedgEntryInsert', '', true, true)]

    local procedure OnAfterCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldLedgEntryInserted: Boolean)
    var
        Customer: Record Customer;
        Url: Text[250];
        CustomerApiUrlTok: Label 'v2.0/companies(%1)/customers(%2)', Locked = true;
    begin
        if not Customer.get(CustLedgerEntry."Customer No.") then
            exit;
        Url := GetBaseUrl() + StrSubstNo(CustomerApiUrlTok, GetCompanyId(), TrimId(Customer.SystemId));
        if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment then
            MyBusinessEventSalesPaymentPosted(Customer.SystemId, Url);
        if Customer."Credit Limit (LCY)" <= 0 then
            exit;
        Customer.CalcFields("Balance (LCY)");
        if Customer."Balance (LCY)" > Customer."Credit Limit (LCY)" then
            MyBusinessEventSalesCreditLimitExceeded(Customer.SystemId, Url)
    end;

    [ExternalBusinessEvent('SalesPaymentPosted', 'Sales payment posted', 'This business event is triggered when a customer payment is posted as part of the Quote to Cash process.', EventCategory::"My Accounts Receivable Events")]
    local procedure MyBusinessEventSalesPaymentPosted(CustomerId: Guid; Url: text[250])
    begin
    end;

    [ExternalBusinessEvent('SalesCreditLimitExceeded', 'Sales credit limit exceeded', 'This business event is triggered when the credit limit for a customer is exceeded due to a posted sales invoice/changed credit limit for that customer.', EventCategory::"My Accounts Receivable Events")]
    local procedure MyBusinessEventSalesCreditLimitExceeded(CustomerId: Guid; Url: text[250])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterVendLedgEntryInsert', '', true, true)]
    local procedure OnAfterVendorLedgEntryInsert(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldLedgEntryInserted: Boolean)
    var
        Vendor: Record Vendor;
        Url: Text[250];
        CustomerApiUrlTok: Label 'v2.0/companies(%1)/vendors(%2)', Locked = true;
    begin
        if not Vendor.get(VendorLedgerEntry."Vendor No.") then
            exit;
        Url := GetBaseUrl() + StrSubstNo(CustomerApiUrlTok, GetCompanyId(), TrimId(Vendor.SystemId));
        if VendorLedgerEntry."Document Type" = VendorLedgerEntry."Document Type"::Payment then
            MyBusinessEventPurchasePaymentPosted(Vendor.SystemId, Url);
    end;

    [ExternalBusinessEvent('PurchasePaymentPosted', 'Purchase payment posted', 'This business event is triggered when a vendor payment is posted as part of the Procure to Pay process.', EventCategory::"My Accounts Receivable Events")]
    local procedure MyBusinessEventPurchasePaymentPosted(VendorId: Guid; Url: text[250])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePosting', '', true, true)]
    local procedure OnAfterFinalizePosting(
    var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header";
    var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    PreviewMode: Boolean; CommitIsSupressed: Boolean)

    var
        Url: Text[250];
        PurchaseInvoiceApiUrlTok: Label 'v2.0/companies(%1)/purchaseInvoices(%2)', Locked = true;
        PurchaseReceiptsApiUrlTok: Label 'v2.0/companies(%1)/purchaseReceipts(%2)', Locked = true;
    begin
        if PurchInvHeader."No." <> '' then begin
            Url := GetBaseUrl() + StrSubstNo(PurchaseInvoiceApiUrlTok, GetCompanyId(), TrimId(PurchInvHeader.SystemId));
            MyBusinessEventPurchaseInvoicePosted(PurchInvHeader.SystemId, Url);
        end;
        if PurchRcptHeader."No." <> '' then begin
            Url := GetBaseUrl() + StrSubstNo(PurchaseReceiptsApiUrlTok, GetCompanyId(), TrimId(PurchRcptHeader.SystemId));
            MyBusinessEventPurchaseReceivedPosted(PurchRcptHeader.SystemId, Url);
        end;
    end;

    [ExternalBusinessEvent('PurchaseInvoicePosted', 'Purchase invoice posted', 'This business event is triggered when a vendor invoice is posted as part of the Procure to Pay process.', EventCategory::"My Accounts Payable Events")]
    local procedure MyBusinessEventPurchaseInvoicePosted(PurchaseInvoiceId: Guid; Url: text[250])
    begin
    end;

    [ExternalBusinessEvent('PurchaseReceiptPosted', 'Purchase receipt posted', 'This business event is triggered when goods from a purchase order are received by the internal warehouse/external logistics company. This can trigger Finance Department to post a purchase invoice.', EventCategory::"My Accounts Payable Events")]
    local procedure MyBusinessEventPurchaseReceivedPosted(PurchaseInvoiceId: Guid; Url: text[250])
    begin
    end;



    // EXT_BUSINESS_EVENT::"SALESORDERELEASED"
    [ExternalBusinessEvent('SalesOrderReleased', 'Sales order released', 'This business event is triggered when a sales order is released ',
    EventCategory::"My Sales Events")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"Sales Header", 'R')] // optional

    // Business Event Name : "MyBusinessEventSalesOrderReleased"
    local procedure MyBusinessEventSalesOrderReleased(SalesHeaderID: Guid; Url: text[250])
    begin
    end;


    // Subcription to 'OnAfterReleaseSalesDoc'
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', true, true)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        Url: Text[250];
        SalesOrderApiUrlTok: Label 'v2.0/companies(%1)/salesOrders(%2)', Locked = true;
        SaledOrder: Record "Sales Header";
        RecrefSO: RecordRef;
        InstreamSO: InStream;
        OutstreamSO: OutStream;
        Base64Text: text;
        Base64Conv: Codeunit "Base64 Convert";     // BASE 64 CONVERT
        TempBlobCu: Codeunit "Temp Blob";          // TEMP BLOB CU

    begin
        if SalesHeader.Status = SalesHeader.Status::Released then begin

            //Set URL
            Url := GetBaseUrl() + StrSubstNo(SalesOrderApiUrlTok, GetCompanyId(), TrimId(SalesHeader.SystemId));

            //Print Sales Order Confirmation
            SaledOrder.SetRecFilter();
            RecrefSO.GetTable(SalesHeader);
            OutstreamSO := TempBlobCu.CreateOutStream();

            //SAVE REPORT 
            if Report.SaveAs(Report::"Standard Sales - Order Conf.", '', ReportFormat::Pdf, OutstreamSO, RecRefSO) then begin
                InstreamSO := TempBlobCu.CreateInStream();
                Base64Text := Base64Conv.ToBase64(InstreamSO);

                // Business Event - MyBusinessEventSalesOrderReleased
                MyBusinessEventSalesOrderReleased(SalesHeader.SystemId, Url); //Business Event foer Sales

            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', true, true)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        Url: Text[250];
        PurchaseOrderApiUrlTok: Label 'v2.0/companies(%1)/purchaseOrders(%2)', Locked = true;
    begin
        if PurchaseHeader.Status = PurchaseHeader.Status::Released then begin
            Url := GetBaseUrl() + StrSubstNo(PurchaseOrderApiUrlTok, GetCompanyId(), TrimId(PurchaseHeader.SystemId));
            MyBusinessEventPurchaseOrderReleased(PurchaseHeader.SystemId, Url);
        end;
    end;

    [ExternalBusinessEvent('PurchaseOrderReleased', 'Purchase order released', 'This business event is triggered when a purchase order is released to the internal warehouse/external logistics company, so they''re ready to receive goods coming their way. This trigger occurs when the Release button is clicked on Purchase Order page in Business Central.', EventCategory::"My Purchasing Events")]
    local procedure MyBusinessEventPurchaseOrderReleased(PurchaseInvoiceId: Guid; Url: text[250])
    begin
    end;


    local procedure GetBaseUrl(): text
    begin
        exit(GetUrl(CLIENTTYPE::Api));
    end;

    local procedure GetCompanyId(): text
    var
        Company: Record Company;
    begin
        Company.Get(CompanyName);
        exit(TrimId(Company.SystemId));
    end;

    local procedure TrimId(Id: Guid): Text
    begin
        exit(DelChr(Format(Id), '<>', '{}'));
    end;
}
