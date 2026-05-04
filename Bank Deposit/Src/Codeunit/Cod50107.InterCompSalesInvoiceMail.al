codeunit 50107 "Inter Comp Sales Inv Mail NAL"
{
    Permissions = tabledata "Sales Invoice Header" = RM;
    trigger OnRun()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvHeader2: Record "Sales Invoice Header";
        EmailSetup: Record "Inter Company Email Setup NAL";
    begin
        EmailSetup.Get();
        EmailSetup.TestField("CTS Customer");
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("Sell-to Customer No.", EmailSetup."CTS Customer");
        SalesInvHeader.SetRange("Mail Sent NAL", false);
        if SalesInvHeader.FindSet() then
            repeat
                if SendMailFromPostedSalesInvoice(SalesInvHeader) then begin
                    SalesInvHeader2.Get(SalesInvHeader."No.");
                    SalesInvHeader2."Mail Sent NAL" := true;
                    SalesInvHeader2."Mail Sent On NAL" := CreateDateTime(WorkDate(), Time);
                    SalesInvHeader2.Modify();
                end;
            until SalesInvHeader.Next() = 0;
    end;

    [TryFunction]
    procedure SendMailFromPostedSalesInvoice(var SalesInvHeader: Record "Sales Invoice Header")
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        MailSubject: Text;
        MailBody: Text;
        FileName: Text;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        SalesInvHeader2: Record "Sales Invoice Header";
        MyReport: Report "Standard Sales - Invoice";
        EmailSetup: Record "Inter Company Email Setup NAL";
        InStr: InStream;
        BodyText: Text;
    begin
        EmailSetup.Get();
        EmailSetup.CalcFields("Email body RichText");
        EmailSetup."Email body RichText".CreateInStream(InStr);
        InStr.ReadText(BodyText);

        MailSubject := EmailSetup."Email Subject" + ' ' + Format(WorkDate());
        EmailMessage.Create(EmailSetup."Recepient Email Addresses", MailSubject, ' ', true);
        SalesInvHeader2.SetRange("No.", SalesInvHeader."No.");
        if SalesInvHeader2.FindFirst() then;
        EmailMessage.appendtobody(StrSubstNo(BodyText, SalesInvHeader."No.", SalesInvHeader."Sell-to Customer Name", Format(UserId())));
        FileName := 'InterCompanySalesInvoice' + '_' + Format(SalesInvHeader."No.") + '.pdf';
        TempBlob.CreateOutStream(OutStream);
        MyReport.SetTableView(SalesInvHeader2);
        MyReport.SaveAs('', ReportFormat::Pdf, OutStream);
        TempBlob.CreateInStream(InStream);
        EmailMessage.AddAttachment(FileName, 'application/pdf', InStream);
        Email.Send(EmailMessage);
        Clear(EmailMessage);
        Clear(Email);
    end;
}
