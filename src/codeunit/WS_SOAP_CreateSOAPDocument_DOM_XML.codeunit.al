codeunit 50103 "SOAP Document"
{
    var
        XMLDomMgt: Codeunit "XML DOM Mgt.";  //DOM XML Management
        file: Codeunit "File Management";
        SoapNS11: Label 'http://schemas.xmlsoap.org/soap/envelope/', Locked = true;
        SoapNS12: Label 'http://www.w3.org/2003/05/soap-envelope', Locked = true;
        XsiNS: Label 'http://www.w3.org/2001/XMLSchema-instance', Locked = true;
        XsdNS: Label 'http://www.w3.org/2001/XMLSchema', Locked = true;

    //Use this function to Create a Soap Message
    procedure CreateSOAPMessage();
    var
        lXmlDocument: XmlDocument;
        lEnvolopeXmlNode: XmlNode;
        lHeaderXmlNode: XmlNode;
        lBodyXmlNode: XmlNode;
        lTempXmlNode: XmlNode;
        lXMLText: Text;
    begin
        //Create a Soap Document with SOAP
        CreateSoapDocument(lXmlDocument, 1, lEnvolopeXmlNode, lHeaderXmlNode, lBodyXmlNode);

        //Add Additional Nodes to the Soap Headers if Needed- Below is the Sample
        XMLDomMgt.AddElement(lHeaderXmlNode, 'SampleHeaders', 'Test', SoapNS12, lTempXmlNode);

        //You can add/append an existing Node to the Soap Body using XmlNode.AsXmlElement.InnerXml - Below is the Sample
        XMLDomMgt.AddElement(lBodyXmlNode, 'SampleBody', 'Test', SoapNS12, lTempXmlNode);

        lXmlDocument.WriteTo(lXMLText);
        Message(lXMLText);
    end;

    //Use this function to Create a Soap Document with Soap Version 1.1 & 1.2. This function will return the XML Document along with the reference of the created nodes like Envelope, Header & Body.
    procedure CreateSOAPDocument(var pXmlDocument: XmlDocument; pVersion: Option "1.1","1.2"; var pEnvelopeXmlNode: XmlNode; var pHeaderXmlNode: XmlNode; var pBodyXmlNode: XmlNode);
    begin
        //SOAP Document
        CreateEnvelope(pXmlDocument, pEnvelopeXmlNode, pVersion);
        CreateHeader(pEnvelopeXmlNode, pHeaderXmlNode, pVersion);
        CreateBody(pEnvelopeXmlNode, pBodyXmlNode, pVersion);
    end;

    //Use this function to Create a Soap Document with Soap Version 1.1 & 1.2. This function will return the XML Document along with the reference of the created Body node.
    procedure CreateSOAPDocumentBody(var pXmlDocument: XmlDocument; pVersion: Option "1.1","1.2"; var pBodyXmlNode: XmlNode);
    var
        lEnvelopeXmlNode: XmlNode;
        lHeaderXmlNode: XmlNode;
    begin
        CreateSOAPDocument(pXmlDocument, pVersion, lEnvelopeXmlNode, lHeaderXmlNode, pBodyXmlNode);
    end;

    //This function will create a Soap Envelope
    procedure CreateEnvelope(var pXmlDocument: XmlDocument; var pEnvelopeXmlNode: XmlNode; pVersion: Option "1.1","1.2");
    begin
        pXmlDocument := XmlDocument.Create;
        With XMLDomMgt do begin
            AddDeclaration(pXmlDocument, '1.0', 'UTF-8', 'no');

            if pVersion = pVersion::"1.1" then
                AddRootElementWithPrefix(pXmlDocument, 'Envelope', 'Soap', SoapNS11, pEnvelopeXmlNode)
            else
                AddRootElementWithPrefix(pXmlDocument, 'Envelope', 'Soap', SoapNS12, pEnvelopeXmlNode);

            AddPrefix(pEnvelopeXmlNode, 'xsi', XsiNS);
            AddPrefix(pEnvelopeXmlNode, 'xsd', XsdNS);
        end;
    end;

    //This function will create a Soap Header
    procedure CreateHeader(var pEnvelopeXmlNode: XmlNode; var pHeaderXmlNode: XmlNode; pVersion: Option "1.1","1.2");
    begin
        if pVersion = pVersion::"1.1" then
            XMLDOMMgt.AddElement(pEnvelopeXmlNode, 'Header', '', SoapNS11, pHeaderXmlNode)
        else
            XMLDOMMgt.AddElement(pEnvelopeXmlNode, 'Header', '', SoapNS12, pHeaderXmlNode);
    end;

    //This function will create a Soap Body
    procedure CreateBody(var pSoapEnvelope: XmlNode; var pSoapBody: XmlNode; pVersion: Option "1.1","1.2");
    begin
        if pVersion = pVersion::"1.1" then
            XMLDOMMgt.AddElement(pSoapEnvelope, 'Body', '', SoapNS11, pSoapBody)
        else
            XMLDOMMgt.AddElement(pSoapEnvelope, 'Body', '', SoapNS12, pSoapBody);
    end;

}