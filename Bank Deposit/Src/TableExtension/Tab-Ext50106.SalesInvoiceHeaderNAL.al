tableextension 50106 "Sales Invoice Header NAL" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Mail Sent"; Boolean)
        {
            Caption = 'Mail Sent';
            DataClassification = ToBeClassified;
        }
        field(50101; "Mail Sent On"; DateTime)
        {
            Caption = 'Mail Sent On';
            DataClassification = ToBeClassified;
        }
    }
}
