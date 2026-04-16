tableextension 50106 "Sales Invoice Header NAL" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Mail Sent NAL"; Boolean)
        {
            Caption = 'Mail Sent';
            DataClassification = ToBeClassified;
        }
        field(50101; "Mail Sent On NAL"; DateTime)
        {
            Caption = 'Mail Sent On';
            DataClassification = ToBeClassified;
        }
    }
}
