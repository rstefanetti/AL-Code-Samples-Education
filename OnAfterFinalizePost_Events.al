** example **

codeunit 51123 OnAfterFinalizePost
{
    trigger OnRun()
    begin

    end;


    // DEMO EXAMPLE
    /* example of printing the “Purchase -Receipt” after the goods are received. 
    This will generate a base64 string and sent is over to Power Automate to send it by mail. 
    Or you can store it in a file storage or what you want. */


    // EVENTS SCUBSCRIVING - ONAFTER FINALIZING POSTING
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePosting', '', true, true)]
    local procedure OnAfterFinalizePosting(
       var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header";
       var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
       var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
       PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        Url: Text[250];
        PurchaseReceiptsApiUrlTok: Label 'v2.0/companies(%1)/purchaseReceipts(%2)', Locked = true;
        Outstream: OutStream;
        Instream: InStream;
        RecRef: RecordRef;
        Variant: Variant;
        Base64: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        Base64Text: Text;

    begin
        if PurchRcptHeader."No." <> '' then begin
            Url := GetBaseUrl() + StrSubstNo(PurchaseReceiptsApiUrlTok, GetCompanyId(), TrimId(PurchRcptHeader.SystemId));

            //Print purchase receipt
            PurchRcptHeader.SetRecFilter();
            Recref.GetTable(PurchRcptHeader);
            Outstream := TempBlob.CreateOutStream();

            if Report.SaveAs(Report::"Purchase - Receipt", '', ReportFormat::Pdf, Outstream, RecRef) then begin
                Instream := TempBlob.CreateInStream();
                Base64Text := Base64.ToBase64(Instream);

                //  MyBusinessEventPurchaseReceivedPosted(PurchRcptHeader.SystemId, Url, Base64Text);

            end;
        end;
    end;


    // PROCEDURES
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
