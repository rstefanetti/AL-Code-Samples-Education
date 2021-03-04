table 61105 "table_Images"
{
    DataClassification = ToBeClassified;
    Caption = 'Immagini caricate';
    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;

        }
        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                importa_Immagine();
            end;

        }
        field(3; Image; Blob)
        {
            Subtype = Bitmap;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    /* fieldgroups
     {
         fieldgroup(Brick; "No.", Image)
         {
         }
     }*/

    local procedure Importa_Immagine()
    var

        fileName: Text;
        inStreamImage: InStream;
        OutStreamImage: OutStream;
        res: Boolean;
    begin


        res := UploadIntoStream('Seleziona immagine', '', 'All Files (*.bmp)|*.bmp', fileName, inStreamImage);

        if (res = true) then begin

            Image.CreateOutStream(OutStreamImage);
            CopyStream(OutStreamImage, inStreamImage);


            Message('Immagine importata No. %1', "No.");

        end
        else
            Message('Importazioe Annullata!');


    end;



}

