pageextension 50108 "Purchase Credit Memo2 NAL" extends "Purchase Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("Load Number NAL"; Rec."Load Number NAL")
            {
                ApplicationArea = All;
            }
        }
    }
}
