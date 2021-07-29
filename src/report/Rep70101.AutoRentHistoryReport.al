report 70101 "Auto Rent History Report"
{
    Caption = 'Auto Rent History Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/reportlayouts/R70101.rdl';


    dataset
    {
        dataitem(Auto; Auto)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(Auto_Mark; "Auto Mark")
            { }
            column(Auto_Model; "Auto Model")
            { }
            dataitem("Finished Auto Rent Header"; "Finished Auto Rent Header")
            {
                DataItemLink = "Car No." = field("No.");
                DataItemTableView = sorting("Car No.");
                column(Rezervation_From; "Rezervation From")
                { }
                column(Rezervation_Until; "Rezervation Until")
                { }
                column(Customer_No_; "Customer No.")
                { }
                column(Amount; Amount)
                { }
                column(AllAmount; AllAmount)
                { }
            }
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(FromDateControl; FromDate)
                    {
                        Caption = 'From Date';
                        ApplicationArea = all;
                    }
                    field(UntilDateControl; UntilDate)
                    {
                        Caption = 'Until Date';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    labels
    {
        ReportTitle = 'Auto Rent History';
    }
    trigger OnPreReport()
    var
        FinishedAutoRent: Record "Finished Auto Rent Header";
    begin
        if FromDate <> 0D then
            FinishedAutoRent.Setfilter("Rezervation From", '>=%1', FromDate);
        if UntilDate <> 0D then
            FinishedAutoRent.Setfilter("Rezervation Until", '<=%1', UntilDate);
    end;

    var
        AllAmount: Decimal;
        FromDate: Date;
        UntilDate: Date;
}