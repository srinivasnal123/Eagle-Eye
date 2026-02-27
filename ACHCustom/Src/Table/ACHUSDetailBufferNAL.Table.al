//Dummy table to store the values of Transit Routing No's
table 50150 "Data Exch. Field Buffer NAL"
{
    Caption = 'Data Exch. Field Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Data Exch. No."; Integer)
        {
            Caption = 'Data Exch. No.';
            NotBlank = true;
            TableRelation = "Data Exch.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(3; "Column No."; Integer)
        {
            Caption = 'Column No.';
            NotBlank = true;
        }
        field(4; Value; Text[250])
        {
            Caption = 'Value';
        }
        field(6; "Data Exch. Line Def Code"; Code[20])
        {
            Caption = 'Data Exch. Line Def Code';
            TableRelation = "Data Exch. Line Def".Code;
        }
        field(11; "Data Exch. Def Code"; Code[20])
        {
            CalcFormula = lookup("Data Exch."."Data Exch. Def Code" where("Entry No." = field("Data Exch. No.")));
            Caption = 'Data Exch. Def Code';
            FieldClass = FlowField;
        }
        field(16; "Value BLOB"; BLOB)
        {
            Caption = 'Value BLOB';
        }
        field(17; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}