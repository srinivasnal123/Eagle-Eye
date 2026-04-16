table 50100 "Inter Company Email Setup NAL"
{
    Caption = 'Inter Company Email Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(2; "Recepient Email Addresses"; Text[1024])
        {
            Caption = 'Recepient Email Addresses';
        }
        field(3; "Email Subject"; Text[200])
        {
            Caption = 'Email Subject';
        }
        field(4; "Email Body RichText"; blob)
        {
            Caption = 'Email Body';
        }
        field(5; "CTS Customer"; code[20])
        {
            Caption = 'CTS Customer';
            TableRelation = Customer."No.";
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetRichText(): Text
    var
        InStream: Instream;
        TextValue: Text;
    begin
        Rec.CalcFields(Rec."Email body RichText");
        Rec."Email body RichText".CreateInStream(InStream);
        InStream.Read(TextValue);

        exit(TextValue);
    end;

    procedure SaveRichText(RichText: Text)
    var
        OutStream: OutStream;
    begin
        Rec."Email body RichText".CreateOutStream(OutStream);
        OutStream.Write(RichText);
        Rec.Modify();
    end;
}
