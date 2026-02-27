pageextension 50110 "Posted Sales Credit Memo NAL" extends "Posted Sales Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("Load No."; Rec."Load No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
