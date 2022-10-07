// DEMO SNAPSHOT DEBUGGER
pageextension 57000 "RSBCustomerList_ext" extends "Customer List"
{

    actions
    {
        addlast(processing)
        {
            action(AltERStartMyprocess)
            {
                caption = 'Start My Process';
                ApplicationArea = all;
                image = Start;
                promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    isError: Boolean;
                    lblError: Label 'OH OH,, rilevati errori!';
                    lblSuccess: Label 'Processo completato senza errori';

                Begin
                    isError := True;
                    if isError then
                        error(lblError)
                    else
                        message(lblSuccess);
                End;

            }
        }
    }
}
