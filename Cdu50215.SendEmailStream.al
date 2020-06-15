codeunit 50215 SendEmailStream
{
    PROCEDURE ReportSendMail(ReportToSend: Integer; Recordr: RecordRef; ToAddr: List of [Text]; Subject: Text[100]; Body: Text[100]; AttachmentName: Text[100]): Boolean
    var
        outStreamReport: OutStream;
        inStreamReport: InStream;
        Parameters: Text;
        tempBlob: Codeunit "Temp Blob";
        Base64EncodedString: Text;
        Mail: Codeunit "SMTP Mail";
        SmtpConf: Record "SMTP Mail Setup";

    begin
        //SMTP
        SmtpConf.GET();
        TempBlob.CreateOutStream(outStreamReport);
        TempBlob.CreateInStream(inStreamReport);

        //Print Report
        Report.SaveAs(ReportToSend, Parameters, ReportFormat::Pdf, outStreamReport, Recordr);

        //Create mail
        CLEAR(Mail);
        Mail.CreateMessage('Business Central Mailing System', SmtpConf."User ID", ToAddr, Subject, Body);
        Mail.AddAttachmentStream(inStreamReport, AttachmentName);

        //Send mail
        EXIT(Mail.Send());
    end;

    PROCEDURE ReportSendMailWithExternalAttachment(ReportToSend: Integer; Recordr: RecordRef; TableID: Integer; DocNo: Text; ToAddr: List of [Text]; Subject: Text[100]; Body: Text[100]; AttachmentName: Text[100]): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
        outStreamReport: OutStream;
        inStreamReport: InStream;
        TempBlobAtc: Array[10] of Codeunit "Temp Blob";
        outStreamReportAtc: Array[10] of OutStream;
        inStreamReportAtc: Array[10] of InStream;
        Parameters: Text;
        Mail: Codeunit "SMTP Mail";
        SmtpConf: Record "SMTP Mail Setup";

        // Attachments
        FullFileName: Text;
        DocumentAttachment: record "Document Attachment";
        i: Integer;

    begin
        //Email Config     
        SmtpConf.GET();
        clear(Mail);
        Mail.CreateMessage('Business Central Mailing System', SmtpConf."User ID", ToAddr, Subject, Body);

        //Generate blob from report
        TempBlob.CreateOutStream(outStreamReport);
        TempBlob.CreateInStream(inStreamReport);
        Report.SaveAs(ReportToSend, Parameters, ReportFormat::Pdf, outStreamReport, Recordr);
        Mail.AddAttachmentStream(inStreamReport, AttachmentName);
        i := 1;

        //Get attachment from the document - streams
        DocumentAttachment.Reset();
        DocumentAttachment.setrange("Table ID", TableID);
        DocumentAttachment.setrange("No.", DocNo);
        if DocumentAttachment.FindSet() then begin
            repeat
                if DocumentAttachment."Document Reference ID".HasValue then begin
                    TempBlobAtc[i].CreateOutStream(outStreamReportAtc[i]);
                    TempBlobAtc[i].CreateInStream(inStreamReportAtc[i]);
                    FullFileName := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";
                    if DocumentAttachment."Document Reference ID".ExportStream(outStreamReportAtc[i]) then begin
                        //Mail Attachments
                        Mail.AddAttachmentStream(inStreamReportAtc[i], FullFileName);
                    end;
                    i += 1;
                end;
            until DocumentAttachment.NEXT = 0;
        end;

        //Send mail
        exit(Mail.Send());
    end;
}
