pageextension 50111 "Posted Purch Credit Memo NAL" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("Load Number NAL"; Rec."Load Number NAL")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}