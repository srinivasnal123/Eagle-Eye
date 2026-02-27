pageextension 50109 "Sales Credit Memo NAL" extends "Sales Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("EE Load Number"; Rec."EE Load Number")
            {
                ApplicationArea = All;
            }
        }
    }
}
