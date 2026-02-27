reportextension 60801 "CV Export Elec. Payments2" extends 11383
{
    dataset
    {
        add(CopyLoop)
        {
            column(RemitTo; RemitTo.Code)
            {
            }
            column(RemitAddr1; RemitAddr[1])
            {
            }
            column(RemitAddr2; RemitAddr[2])
            {
            }
            column(RemitAddr3; RemitAddr[3])
            {
            }
            column(RemitAddr4; RemitAddr[4])
            {
            }
            column(RemitAddr5; RemitAddr[5])
            {
            }
            column(RemitAddr6; RemitAddr[6])
            {
            }
            column(RemitAddr7; RemitAddr[7])
            {
            }
            column(RemitAddr8; RemitAddr[8])
            {
            }
            column(RecBankAccName; RecBankAccName)
            {
            }
            column(RecBankAccNo; RecBankAccNo)
            {
            }
            column(RecBankTransitNo; RecBankTransitNo)
            {
            }
            column(BankNameLbl; BankNameLbl)
            {
            }
            column(BankRoutingNoLbl; BankRoutingNoLbl)
            {
            }
            column(AccountNoLbl; AccountNoLbl)
            {
            }
        }
        modify("Gen. Journal Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                Vendor: Record Vendor;
                VendorBankAccount: Record "Vendor Bank Account";
                FormatAddr: Codeunit "Format Address";
            begin
                Clear(RemitAddr);
                Clear(RemitTo);
                if ("Gen. Journal Line"."Remit-to Code" <> '') and ("Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor) then begin
                    RemitTo.Get("Gen. Journal Line"."Remit-to Code", "Gen. Journal Line"."Account No.");
                    FormatAddr.VendorRemitToAddress(RemitTo, RemitAddr);
                end
                else if "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor then begin
                    Vendor.Get("Account No.");
                    FormatAddr.Vendor(RemitAddr, Vendor);
                end;
                if ("Gen. Journal Line"."Recipient Bank Account" <> '') and ("Account Type" = "Account Type"::Vendor) then begin
                    if VendorBankAccount.Get("Account No.", "Recipient Bank Account") then begin
                        RecBankAccName := VendorBankAccount.Name;
                        RecBankTransitNo := PerformMasking(VendorBankAccount."Transit No.");
                        RecBankAccNo := PerformMasking(VendorBankAccount."Bank Account No.");
                    end;
                end
                else begin
                    RecBankAccName := '';
                    RecBankTransitNo := '';
                    RecBankAccNo := '';
                end;
            end;
        }
    }
    var
        RemitTo: Record "Remit Address";
        RemitAddr: array[8] of Text[100];
        RecBankAccName: Text[100];
        RecBankTransitNo: Text[20];
        RecBankAccNo: Text[30];
        BankNameLbl: Label 'Bank Name:';
        AccountNoLbl: Label 'Account No.:';
        BankRoutingNoLbl: Label 'Bank Routing No.';

    procedure PerformMasking(MastText: Text[30]): Text
    begin
        if Strlen(MastText) > 4 then
            exit('XXXXXXXX' + MastText.Substring(strlen(MastText) - 3))
        else
            exit('');
    end;
}
