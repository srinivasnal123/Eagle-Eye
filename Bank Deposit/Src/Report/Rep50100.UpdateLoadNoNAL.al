report 50100 "Update Load No NAL"
{
    ApplicationArea = All;
    Caption = 'Update Load No';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    Permissions = tabledata "Sales Invoice Header" = RM, tabledata "Purch. Inv. Header" = RM, tabledata "Sales Invoice Line" = RM,
                  tabledata "Sales Cr.Memo Header" = RM, tabledata "Purch. Cr. Memo Hdr." = RM;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = where("Pre-Assigned No." = filter(<> ''));
            trigger OnAfterGetRecord()
            begin
                "EE Load Number" := "Sales Invoice Header"."Pre-Assigned No.";
                Modify();
            end;

            trigger OnPostDataItem()
            begin
                Commit();
            end;
        }
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = where("Pre-Assigned No." = filter(<> ''));
            trigger OnAfterGetRecord()
            begin
                "Load Number NAL" := "Purch. Inv. Header"."Pre-Assigned No.";
                Modify();
            end;

            trigger OnPostDataItem()
            begin
                Commit();
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = where("Applies-to Doc. No." = filter(<> ''), "Applies-to Doc. Type" = const(Invoice));

            trigger OnAfterGetRecord()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
            begin
                if SalesInvoiceHeader.Get("Applies-to Doc. No.") and (SalesInvoiceHeader."Pre-Assigned No." <> '') then begin
                    "Load No." := SalesInvoiceHeader."Pre-Assigned No.";
                    Modify();
                end;
            end;
        }

        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = where("Applies-to Doc. No." = filter(<> ''), "Applies-to Doc. Type" = const(Invoice));

            trigger OnAfterGetRecord()
            var
                PurchInvHeader: Record "Purch. Inv. Header";
            begin
                if PurchInvHeader.Get("Applies-to Doc. No.") and (PurchInvHeader."Pre-Assigned No." <> '') then begin
                    "Load Number NAL" := PurchInvHeader."Pre-Assigned No.";
                    Modify();
                end;
            end;
        }
    }
    trigger OnPreReport()
    begin
        if not Confirm('Do you want to update Load No. in Sales and Purchase Invoice/Cr.Memo Headers?')
        then
            CurrReport.Quit();
    end;

    trigger OnPostReport()
    begin
        Message('Load No. updated successfully in Sales and Purchase Invoice/Cr.Memo Headers.');
    end;
}
