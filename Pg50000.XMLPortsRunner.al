page 50000 "DMT - XMLPorts - Runner"
{
    // XMLPORTS Runner
    PageType = Card;
    Editable = True;
    UsageCategory = Tasks; //show in the Search Menù - "Record Deletion page"
    ApplicationArea = All;
    Caption = 'DMT - XMLPorts Runner';

    layout
    {
        area(content)
        {
            field(import; flagimport)
            {
                ApplicationArea = All;
                Caption = 'Import Data';
            }
            field(numeroxmlport; xmlportno)
            {
                ApplicationArea = All;
                Caption = 'XMLPort Nr.';
            }
        }
    }
    actions
    {
        area(creation)
        {
            action(runxmlport)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if flagimport = true then
                        RunXMLPortImport
                    else
                        RunXMLPortExport
                end;
            }
        }
    }
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

    procedure RunXMLPortImport()
    begin
        UploadIntoStream('', '', '', FileName, FileInstream);       
        XMLPORT.Import(xmlportno, FileInstream);
        Message('Import Done successfully.');
    end;

    procedure RunXMLPortExport()
    begin
       
        TempBlob.CreateOutStream(MyOutStream);
        XMLPORT.Export(xmlportno, MyOutStream);      
        TempBlob.CreateInStream(MyInStream);
        outputFileName := 'MyOutput.xml';
        DownloadFromStream(MyInStream, '', '', '', outputFileName); //Salvato in Download folder
        Message('Export Done successfully.');
    end;
}
