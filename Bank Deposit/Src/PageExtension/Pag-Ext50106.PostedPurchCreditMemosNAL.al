pageextension 50106 "Posted Purch Credit Memos NAL" extends "Posted Purchase Credit Memos"
{
    layout
    {
        addafter("Due Date")
        {
            field("Load Number NAL"; Rec."Load Number NAL")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Load Number NAL for the purchase credit memo.';
            }
        }
    }
}
