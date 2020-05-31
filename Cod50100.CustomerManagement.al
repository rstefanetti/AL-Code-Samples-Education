codeunit 50100 "Customer Management"
{

    trigger OnRun();
    begin
    end;

    procedure CreateDefaultCategory()
    var
        CustomerCategory: Record "Customer Category";
    begin
        CustomerCategory.No := 'DEFAULT';
        CustomerCategory.Description := 'Default Customer Category';
        CustomerCategory.Default := true;
        if CustomerCategory.Insert then;
    end;


    procedure AssignDefaultCategory(CustomerCode: Code[20])
    var
        Customer: Record Customer;
        CustomerCategory: Record "Customer Category";
    begin
        //Set default category for a Customer        
        Customer.Get(CustomerCode);
        CustomerCategory.SetRange(Default, true);
        if CustomerCategory.FindFirst() then begin
            Customer."Customer Category SDM" := CustomerCategory.No;
            Customer.Modify();
        end;
    end;

    procedure AssignDefaultCategory()
    var
        Customer: Record Customer;
        CustomerCategory: Record "Customer Category";
    begin
        //Set default category for ALL Customer       
        CustomerCategory.SetRange(Default, true);
        if CustomerCategory.FindFirst() then begin
            if Customer.FindSet() then
                repeat
                    Customer."Customer Category SDM" := CustomerCategory.No;
                    Customer.Modify();
                until Customer.Next() = 0;
        end;
    end;

    //Returns the number of Customers without an assigned Customer Category
    procedure GetTotalCustomersWithoutCategory(): Integer
    var
        Customer: record Customer;
    begin
        Customer.SetRange("Customer Category SDM", '');
        exit(customer.Count());
    end;

    procedure RetrieveNames()
    var
        customer: record Customer;
        customerNamesList: List of [Text];
        name: Text;
    //Esempio per fare una DISTINCT di Nomi cliente
    begin
        if customer.FindSet() then
            repeat
            begin
                if not customerNamesList.Contains(customer.Name) then
                    customerNamesList.Add(customer.Name);
            end
            until customer.Next = 0;
        Message('NOMI DISTINTI: ' + Format(customerNamesList.Count));
        foreach name in customerNamesList do
            Message(name);
    end;

    local procedure CreateCustomerXML(CustomerNo: Code[20])
    var
        Customer: Record Customer;
        xmlDoc: XmlDocument;
        xmlDec: XmlDeclaration;
        xmlElem: XmlElement;
        xmlElem2: XmlElement;
        TempBlob: Record TempBlob Temporary;
        outStr: OutStream;
        inStr: InStream;
        TempFile: File;
        fileName: Text;
    begin
        Customer.Get(CustomerNo);
        xmlDoc := xmlDocument.Create();
        xmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        xmlDoc.SetDeclaration(xmlDec);
        xmlElem := xmlElement.Create('root');
        xmlElem.SetAttribute('release', '2.1');
        xmlElem2 := XmlElement.Create('No');
        xmlElem2.Add(xmlText.Create(Customer."No."));
        xmlElem2 := XmlElement.Create('Name');
        xmlElem2.Add(xmlText.Create(Customer.Name));
        xmlElem2 := XmlElement.Create('Category');
        xmlElem2.Add(xmlText.Create(Customer."Customer Category SDM"));
        xmlElem.Add(xmlElem2);
        xmlDoc.Add(xmlElem);
        // Create an out stream from the blob, notice the encoding.
        TempBlob.Blob.CreateOutStream(outStr, TextEncoding::UTF8);
        // Write the contents of the doc to the stream
        xmlDoc.WriteTo(outStr);
        // From the same blob, that now contains the xml document, create an instr
        TempBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);

        // Save the data of the InStream as a file.
        File.DownloadFromStream(inStr, 'Export', '', '', fileName);
    end;

}