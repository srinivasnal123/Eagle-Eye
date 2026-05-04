page 50100 "Inter Company Email Setup NAL"
{
    ApplicationArea = All;
    Caption = 'InterCompany Email Setup';
    PageType = Card;
    SourceTable = "Inter Company Email Setup NAL";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Recepient Email Addresses"; Rec."Recepient Email Addresses")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the email addresses of the recipients. Separate multiple email addresses with a semicolon.';
                }
                field("Email Subject"; Rec."Email Subject")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the subject of the email.';
                }
                field("CTS Customer"; Rec."CTS Customer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer uggests the customer which will be used to send email';
                }
            }
            group(fasttabgroup)
            {
                Caption = 'Email Body';
                field("Email body RichText"; RichText)
                {
                    ToolTip = 'Specifies the value of the Email body field.', Comment = '%';
                    MultiLine = true;
                    ShowCaption = false;
                    ExtendedDatatype = RichContent;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Rec.SaveRichText(RichText);
                    end;

                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RichText := Rec.GetRichText();
    end;


    var
        RichText: Text;
}
