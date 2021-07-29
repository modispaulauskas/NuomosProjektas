page 70103 "Auto List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Auto;
    CardPageId = "Auto Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field("Auto Name"; Rec."Auto Name")
                {
                    Caption = 'Auto Name';
                    ApplicationArea = All;
                }
                field("Auto Mark"; Rec."Auto Mark")
                {
                    Caption = 'Auto Mark';
                    ApplicationArea = All;
                }
                field("Auto Model"; Rec."Auto Model")
                {
                    Caption = 'Auto Model';
                    ApplicationArea = All;
                }
                field("Make Year"; Rec."Make Year")
                {
                    Caption = 'Make Year';
                    ApplicationArea = All;
                }
                field("Civil Insurance Until"; Rec."Civil Insurance Until")
                {
                    Caption = 'Civil Insurance Until';
                    ApplicationArea = All;
                }
                field("Technical Validity Until"; Rec."Technical Validity Until")
                {
                    Caption = 'Technical Validity Until';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                    TableRelation = Location;
                }
                field("Rent Service"; Rec."Rent Service")
                {
                    Caption = 'Rent Service';
                    ApplicationArea = All;
                }
                field("Rent Price"; Rec."Rent Price")
                {
                    Caption = 'Rent Price';
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Reservations)
            {
                Caption = 'Auto Reservations';
                action(ReservateAuto)
                {
                    Caption = 'Reservate Auto';
                    ApplicationArea = All;
                    RunObject = page "Auto Reservation";
                    RunPageLink = "Auto No." = field("No.");
                }
                action(CheckReserved)
                {
                    Caption = 'Check Reserved Autos';
                    ApplicationArea = All;
                    RunObject = page "Auto Valid Reservations";
                    RunPageLink = "Auto No." = field("No.");
                }
            }
            action(ShowDamages)
            {
                Caption = 'Show Damages';
                ApplicationArea = All;
                Image = ShowList;
                RunObject = page "Auto Damage";
                RunPageLink = "Auto No." = field("No.");
            }
        }
        area(Reporting)
        {
            action(ShowHistoryReport)
            {
                Caption = 'Show History Report';
                ApplicationArea = All;
                Image = Report;
                trigger OnAction()
                begin
                    RunReport(Rec."No.");
                end;
            }
        }
    }
    procedure RunReport(CarNo: Code[20])
    var
        AutoList: Record Auto;
        AutoHistoryReport: Report "Auto Rent History Report";
    begin
        AutoList.SetRange("No.", CarNo);
        REPORT.RunModal(70101, true, true, AutoList);
    end;
}