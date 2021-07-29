codeunit 70101 "Auto Header Management"
{
    procedure PerformManualClose(var AutoRentHeader: Record "Auto Rent Header")
    begin
        if AutoRentHeader."Status" = AutoRentHeader."Status"::Issued then
            exit;

        AutoRentHeader.TestField("No.");
        AutoRentHeader.TestField("Customer No.");
        AutoRentHeader.TestField("Date");
        AutoRentHeader.TestField("Car No.");
        AutoRentHeader.TestField("Rezervation From");
        AutoRentHeader.TestField("Rezervation Until");

        AutoRentHeader."Status" := AutoRentHeader."Status"::Issued;
        AutoRentHeader.Modify(true);
    end;


    procedure PerformReturnToday(var AutoRentHeader: Record "Auto Rent Header")
    begin
        AutoRentHeader."Rezervation Until" := Today();
        AutoRentHeader.Modify(true);
    end;
}