pageextension 50104 "Purchase Credit Memos NAL" extends "Purchase Credit Memos"
{
    layout
    {
        addafter("Location Code")
        {
            field("Load Number NAL"; Rec."Load Number NAL")
            {
                ApplicationArea = All;
            }
        }
    }
}
