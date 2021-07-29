page 70111 "Auto Valid Reservations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    Caption = 'Auto No.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                }
                field("Reservation From"; Rec."Reservation From")
                {
                    Caption = 'Rezervation From';
                    ApplicationArea = All;
                }
                field("Reservation Until"; Rec."Reservation Until")
                {
                    Caption = 'Rezervation Until';
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    trigger OnOpenPage()
    var
        TodayDate: Date;
    begin
        TodayDate := Today();
        SetFilter("Reservation Until", '%1..', TodayDate);
    end;
}