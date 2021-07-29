page 70105 "Auto Reservation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                }
                field("Reservation From"; Rec."Reservation From")
                {
                    Caption = 'Reservation From';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckDateFrom();
                    end;
                }
                field("Reservation Until"; Rec."Reservation Until")
                {
                    Caption = 'Reservation Until';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckDateUntil();
                    end;
                }
            }
        }
    }
    procedure CheckDateFrom()
    var
        TempReservation: Record "Auto Reservation";
        ErrorMsgThenReserved: Label 'Date is already reserved';
        ErrorMsgThenBadDate: Label 'Date is before Today';
        AutoHeader: Record "Auto Rent Header";
    begin
        TempReservation.SetRange("Auto No.", Rec."Auto No.");
        if TempReservation.FindSet() then
            repeat
                if Rec."Reservation From" > TempReservation."Reservation From" then
                    if Rec."Reservation From" < TempReservation."Reservation Until" then
                        Error(ErrorMsgThenReserved);
            until TempReservation.Next() = 0;

        if AutoHeader.FindSet() then
            repeat
                if Rec."Reservation From" > AutoHeader."Rezervation From" then
                    if Rec."Reservation From" < AutoHeader."Rezervation Until" then
                        Error(ErrorMsgThenReserved);
            until AutoHeader.Next() = 0;
        if Rec."Reservation From" < Today() then
            Error(ErrorMsgThenBadDate);
    end;
    // Truksta patikrinimo ar Reservation From uzpildytas, kad pildyti Until
    procedure CheckDateUntil()
    var
        TempReservation: Record "Auto Reservation";
        ErrorMsgThenReserved: Label 'Date is already reserved';
        ErrorMsgThenBadDate: Label 'Date is before Reservation From';
        AutoHeader: Record "Auto Rent Header";
    begin
        TempReservation.SetRange("Auto No.", Rec."Auto No.");
        if TempReservation.FindSet() then
            repeat
                if Rec."Reservation Until" > TempReservation."Reservation From" then
                    if Rec."Reservation Until" < TempReservation."Reservation Until" then
                        Error(ErrorMsgThenReserved);
            until TempReservation.Next() = 0;

        if Rec."Reservation Until" <= Rec."Reservation From" then
            Error(ErrorMsgThenBadDate);
    end;
}