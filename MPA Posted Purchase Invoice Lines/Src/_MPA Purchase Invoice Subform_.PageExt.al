pageextension 50141 "MPA Purchase Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Trip No."; Rec."Trip No.")
            {
                ApplicationArea = All;
                Caption = 'Trip No.';
            }
        }
    }
}
