pageextension 50215 PurchOrderCardExt extends "Purchase Order"
{

    actions
    {
        addlast(Print)
        {
            Action("SendOrder&Attachment")
            {
                ApplicationArea = All;
                Caption = 'Send multiple attached Documents';
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Category10;

                trigger OnAction();
                var
                    recuser: Record User;
                    ToAddr: List of [Text];
                    PurchaseHeader: Record "Purchase Header";
                begin
                    //read user email config
                    recuser.Reset();
                    recuser.SetFilter("User Security ID", UserSecurityId());
                    if recuser.FindFirst() then begin

                        //Send email after report building
                        if recuser."Contact Email" <> '' then begin
                            ToAddr.Add(recuser."Contact Email");   //contact email on User
                            PurchaseHeader := Rec;
                            CurrPage.SetSelectionFilter(PurchaseHeader);
                            clear(RecRef);
                            RecRef.GetTable(PurchaseHeader);

                            //send
                            if cuSendMail.ReportSendMailWithExternalAttachment(50102, RecRef, RecRef.number, PurchaseHeader."No.", ToAddr, 'ODA ' + PurchaseHeader."No.", 'Purch. Order Documents', PurchaseHeader."No." + ' ' + PurchaseHeader."Pay-to Name" + '.pdf') then
                                Message(text001);
                        end
                        else
                            Message(text002);
                    end
                    else
                        Message(text003);

                end;
            }
        }
    }

    var
        cuSendMail: Codeunit "SendEmailStream";
        RecRef: RecordRef;
        text001: Label 'Email Sended';
        text002: Label 'Email address not present, go to User page and fill Contact Email field.';
        text003: Label 'User not identified';
}