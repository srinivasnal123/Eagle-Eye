tableextension 50150 "ACH US Footer NAL" extends "ACH US Footer"
{
    fields
    {
        field(50100; "Company Bank Account No. NAL"; Text[30])
        {
            Caption = 'Company Bank Account No. NAL';
            DataClassification = CustomerContent;
        }
        field(50101; "Entry Hash NAL"; Decimal)
        {
            Caption = 'Entry Hash';
            DataClassification = CustomerContent;
        }
    }
}
