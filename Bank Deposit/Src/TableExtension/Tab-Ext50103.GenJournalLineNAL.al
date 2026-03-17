tableextension 50103 "Gen Journal Line NAL" extends "Gen. Journal Line"
{
    fields
    {
        field(50100; "Description 2 NAL"; Text[100])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
    }

    procedure InitNewLine(PostingDate: Date; DocumentDate: Date; VATDate: Date; PostingDescription: Text[100]; ShortcutDim1Code: Code[20]; ShortcutDim2Code: Code[20]; DimSetID: Integer; ReasonCode: Code[10]; PostingDescription2: Text[50])
    var
        GLSetup: Record "General Ledger Setup";
    begin
        Init();
        "Posting Date" := PostingDate;
        "Document Date" := DocumentDate;
        if VATDate = 0D then
            "VAT Reporting Date" := GLSetup.GetVATDate("Posting Date", "Document Date")
        else
            "VAT Reporting Date" := VATDate;
        Description := PostingDescription;
        "Description 2 NAL" := PostingDescription2;
        "Shortcut Dimension 1 Code" := ShortcutDim1Code;
        "Shortcut Dimension 2 Code" := ShortcutDim2Code;
        "Dimension Set ID" := DimSetID;
        "Reason Code" := ReasonCode;
    end;
}
