report 70100 "Auto Rent Report Card"
{
    Caption = 'Auto Rent Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Source/reportlayouts/R70100.rdl';

    dataset
    {
        dataitem("Auto Rent Header"; "Auto Rent Header")
        {
            RequestFilterFields = "No.";
            column(Header_No_; "No.")
            { }
            column(Customer_No_; "Customer No.")
            { }
            column(Car_No_; "Car No.")
            { }
            column(Rezervation_From; "Rezervation From")
            { }
            column(Rezervation_Until; "Rezervation Until")
            { }
            column(All_Amount; Amount)
            { }
            dataitem(Auto; Auto)
            {
                DataItemLink = "No." = field("Car No.");
                DataItemTableView = sorting("No.");
                column(No_; "No.")
                { }
                column(Auto_Mark; "Auto Mark")
                { }
                column(Auto_Model; "Auto Model")
                { }
                column(Rent_Price; "Rent Price")
                { }
            }
            dataitem("Auto Rent Line"; "Auto Rent Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Document_No_; "Document No.")
                { }
                column(Type; Type)
                { }
                column(Quantity; Quantity)
                { }
                column(Price; Price)
                { }
                column(Amount; Amount)
                { }
                column(TotalSumofItems; TotalSumofItems)
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

                }
            }
        }
    }
    labels
    {
        ReportTitle = 'Auto Rent Card';
    }
    var
        TotalSumofItems: Decimal;

}