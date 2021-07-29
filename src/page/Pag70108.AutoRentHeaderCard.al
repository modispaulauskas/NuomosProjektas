page 70108 "Auto Rent Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Auto Rent Header";

    layout
    {
        area(Content)
        {
            group(ContractInfo)
            {
                Caption = 'Contract Info';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if Rec."No." = '' then
                            Rec."No." := Rec.GetRentNoFromNoSeries();
                    end;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                    TableRelation = Customer;
                }
                field("Driver License"; Rec."Driver License")
                {
                    Caption = 'Driver License';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;

                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field("Car No."; Rec."Car No.")
                {
                    Caption = 'Car No.';
                    ApplicationArea = All;
                }
                field("Rezervation From"; Rec."Rezervation From")
                {
                    Caption = 'Rezervation From';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckIfReservationFromValid();
                    end;
                }
                field("Rezervation Until"; Rec."Rezervation Until")
                {
                    Caption = 'Rezervation Until';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckIfReservationUntilValid();
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(AutoRent; "Auto Rent Line Subpage")
            {
                Caption = 'Auto Rent List';
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GiveAuto)
            {
                Caption = 'Give Auto';
                ApplicationArea = All;
                Enabled = rec."Status" <> rec."Status"::Issued;
                Image = Close;

                trigger OnAction()
                var
                    AutoHeaderMng: Codeunit "Auto Header Management";
                begin
                    AutoHeaderMng.PerformManualClose(Rec);
                end;
            }
            action(DeleteDriverLicense)
            {
                ApplicationArea = All;
                Caption = 'Delete Driver License Photo';
                Image = Delete;
                Enabled = rec."Status" <> rec."Status"::Issued;
                trigger OnAction()
                begin
                    DeleteDriverLicense();
                end;
            }
            action(NewDamage)
            {
                ApplicationArea = All;
                Caption = 'New Auto Damage';
                Image = NewDocument;
                Enabled = rec."Status" <> rec."Status"::Open;
                RunObject = page "Auto Rent Damage";
                RunPageLink = "Document No." = field("Car No.");
                trigger OnAction()
                begin
                    Rec.TestField("Car No.");
                end;
            }
            action(ReturnToday)
            {
                Caption = 'Return before Contract End';
                ApplicationArea = All;
                Enabled = rec."Status" <> rec."Status"::Open;
                Image = ReOpen;
                trigger OnAction()
                var
                    AutoHeaderMng: Codeunit "Auto Header Management";
                begin
                    AutoHeaderMng.PerformReturnToday(Rec);
                    Rec.CountRentDays();
                    TransferAutoDamage();
                    TransferAllToFinished();
                end;
            }
            action(ReturnAuto)
            {
                ApplicationArea = All;
                Caption = 'Return Auto';
                Image = Return;
                Enabled = rec."Status" <> rec."Status"::Open;
                trigger OnAction()
                begin
                    TransferAutoDamage();
                    TransferAllToFinished();
                end;
            }
        }
        area(Reporting)
        {
            action(AutoRentReportCard)
            {
                Caption = 'Generate Report Card';
                ApplicationArea = All;
                Image = Report;
                trigger OnAction()
                begin
                    RunReport(Rec."No.");
                end;
            }
        }
    }
    var
        ReservationDateError: Label 'No reservations by this date';
        ReservationCustomerError: Label 'No reservations by this customer';

    procedure TransferAutoDamage()
    var
        AutoRentDamage: Record "Auto Rent Damage";
        AutoDamage: Record "Auto Damage";
    begin
        if AutoRentDamage.FindSet() then
            repeat
                if AutoRentDamage.Get(Rec."Car No.", AutoRentDamage."Line No.") then begin
                    if AutoDamage.FindLast() then;
                    AutoDamage.Init();
                    AutoDamage."Line No." += 10000;
                    AutoDamage.TransferFields(AutoRentDamage);
                    AutoDamage.Insert();
                    AutoRentDamage.Delete();
                end;
            until AutoRentDamage.Next() = 0;

    end;

    procedure CheckIfReservationFromValid()
    var
        ReservationList: Record "Auto Reservation";
        ValidReservation: Boolean;
    begin
        ReservationList.SetRange("Auto No.", Rec."Car No.");
        ReservationList.SetRange("Customer No.", Rec."Customer No.");
        if ReservationList.IsEmpty then
            Error(ReservationCustomerError);
        if ReservationList.FindSet() then
            repeat
                if ReservationList."Reservation From" = Rec."Rezervation From" then begin
                    ValidReservation := true;
                    Rec."Rezervation Until" := 0D;
                end
            until ReservationList.Next() = 0;
        if ValidReservation = false then
            Error(ReservationDateError);
    end;

    procedure CheckIfReservationUntilValid()
    var
        ReservationList: Record "Auto Reservation";
        ValidReservation: Boolean;
        TempInt: Integer;
        TempInt2: Integer;
    begin
        ReservationList.SetRange("Auto No.", Rec."Car No.");
        ReservationList.SetRange("Customer No.", Rec."Customer No.");
        if ReservationList.IsEmpty then
            Error(ReservationCustomerError);
        if ReservationList.FindSet() then
            repeat
                TempInt := ReservationList."Reservation Until" - ReservationList."Reservation From";
                TempInt2 := Rec."Rezervation Until" - Rec."Rezervation From";
                if TempInt = TempInt2 then
                    ValidReservation := true;
            until ReservationList.Next() = 0;
        if ValidReservation = false then
            Error(ReservationDateError);
    end;

    procedure TransferAllToFinished()
    var
        AutoRentHeader: Record "Auto Rent Header";
        FinishedAutoRentHeader: Record "Finished Auto Rent Header";
        AutoRentLine: Record "Auto Rent Line";
        FinishedAutoRentLine: Record "Finished Auto Rent Line";
        HeaderMng: Codeunit "Auto Header Management";
        index: Integer;
    begin
        AutoRentHeader.Get(Rec."No.");
        FinishedAutoRentHeader.Init();
        FinishedAutoRentHeader.TransferFields(AutoRentHeader);
        AutoRentHeader.CalcFields("Driver License");
        FinishedAutoRentHeader."Driver License" := AutoRentHeader."Driver License";
        FinishedAutoRentHeader.Insert();

        AutoRentHeader.Delete();
        AutoRentLine.SetRange(AutoRentLine."Document No.", Rec."No.");
        if AutoRentLine.FindSet() then
            repeat
                FinishedAutoRentLine.Init();
                FinishedAutoRentLine.TransferFields(AutoRentLine);
                FinishedAutoRentLine.Insert();
                AutoRentLine.Delete();
            until AutoRentLine.Next() = 0;
    end;

    procedure RunReport(No: Code[20])
    var
        AutoRentHeader: Record "Auto Rent Header";
        AutoHistoryReport: Report "Auto Rent History Report";
    begin
        AutoRentHeader.SetRange("No.", No);
        REPORT.RunModal(70100, true, true, AutoRentHeader);
    end;
}