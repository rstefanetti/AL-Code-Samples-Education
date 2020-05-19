page 50008  "DMT - Table Runner"
{
    // TABLE RUNNER
    PageType = Card;
    Editable = True;
    UsageCategory = Tasks; //show in the Search Menù - "Record Deletion page"
    ApplicationArea = All;
    Caption = 'DMT - Table Runner';

    layout
    {
        area(content)
        {
            field(ServerString; SrvString)
            {
                ApplicationArea = All;
                Caption = 'Server Connection String ';
            }
            
            field(tableNr; tblNr)
            {
                ApplicationArea = All;
                Caption = 'Table Nr. ';
            }
        }
    }
    actions
    {
        area(creation)
        {
            action(OpenHLink)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin                               
                     OpenLink();          
                end;
            }
        }
    }

    trigger OnOpenPage()
        begin
            SrvString := 'http://localhost:8080/BC150/' 	 //DEFAULT
        end;


    var
        FileInstream: InStream;
        //TempBlob: Record TempBlob;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        MyOutStream: OutStream;
        MyInStream: InStream;
        outputFileName: Text;
        Xmlport1: XMLport "Startup Balance";
        flagimport: Boolean;
        xmlportno: Integer;
        RunningText: text[200];
        SrvString:text[200];
        TblNr:integer;

    procedure OpenLink()
    begin   
       
        RunningText  := SrvString + '?table=' + format(tblNr);
        HYPERLINK(RunningText);  //OPEN HYPERLINK
        
    end;
}
    
