tableextension 50101 "Purchase Setup NAL" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50100; "Vendor No. NAL"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Vendor No.';
        }
        field(50101; "G/L Account No. NAL"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'G/L Account No.';
        }
    }
}