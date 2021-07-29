table 70106 "Auto Rent Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            var
                CustomerLedger: Record "Cust. Ledger Entry";
                ErrorMsg: Label 'Customer is in debt';
                Customer: Record Customer;
            begin
                TestStatusOpen();
                Customer.Get(Rec."Customer No.");
                Customer.CalcFields("Balance (LCY)");
                if Customer."Balance (LCY)" > 0 then
                    Error(ErrorMsg);
            end;
        }
        field(20; "Driver License"; BLOB)
        {
            Caption = 'Driver License';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
            trigger OnValidate()
            begin
                TestStatusOpen();
                PictureUpdated := true;
            end;
        }
        field(30; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(40; "Car No."; Code[20])
        {
            Caption = 'Car No.';
            DataClassification = ToBeClassified;
            TableRelation = Auto;
            trigger OnValidate()
            var
                AutoRentLine: Record "Auto Rent Line";
                Auto: Record Auto;
            begin
                TestStatusOpen();
                GetCarInfo();
                "Rezervation From" := 0D;
                "Rezervation Until" := 0D;
            end;
        }
        field(50; "Rezervation From"; Date)
        {
            Caption = 'Rezervation From';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(60; "Rezervation Until"; Date)
        {
            Caption = 'Rezervation Until';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestStatusOpen();
                CountRentDays();
            end;
        }
        field(70; Amount; Decimal)
        {
            Caption = 'Amount';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Auto Rent Line".Amount where("Document No." = field("No.")));
        }
        field(80; Status; Enum "Auto Rent Header Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var
        PictureUpdated: Boolean;

    procedure DeleteDriverLicense()
    begin
        if "Driver License".HasValue then begin
            CLEAR("Driver License");
            Modify();
        end;
    end;

    procedure TestStatusOpen()
    begin
        TestField("Status", "Status"::Open);
    end;

    procedure GetRentNoFromNoSeries(): Code[20]
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        AutoSetup.Get();
        AutoSetup.TestField("Rent Card Nos.");
        exit(NoSeriesManagement.GetNextNo(AutoSetup."Rent Card Nos.", WorkDate(), true));
    end;

    procedure GetCarInfo()
    var
        AutoRentLine: Record "Auto Rent Line";
        Auto: Record Auto;
        Ct: Integer;
        NoCustomerNoError: Label 'Customer not selected';
    begin
        Ct := 0; // Count
        AutoRentLine.SetRange("Document No.", "No.");
        if AutoRentLine.FindSet() then begin
            repeat
                if AutoRentLine.IsCar then begin
                    Ct += 1;
                    AutoRentLine.Type := AutoRentLine.Type::Resource;
                    Auto.Get("Car No.");
                    AutoRentLine."No." := Auto."Rent Service";
                    Auto.CalcFields("Rent Price");
                    AutoRentLine.Price := Auto."Rent Price";
                    AutoRentLine.Amount := Auto."Rent Price" * AutoRentLine.Quantity;
                    AutoRentLine.Modify();
                end;
            until AutoRentLine.Next = 0;
        end;
        if AutoRentLine.IsEmpty then
            if "No." = '' then begin
                Error(NoCustomerNoError);
            end
            else
                AutoRentLine."Document No." := "No.";
        if Ct = 0 then begin
            if AutoRentLine.FindLast() then;
            AutoRentLine.Init();
            AutoRentLine."Line No." += 10000;
            AutoRentLine.Type := AutoRentLine.Type::Resource;
            Auto.Get("Car No.");
            AutoRentLine."No." := Auto."Rent Service";
            Auto.CalcFields("Rent Price");
            AutoRentLine.Price := Auto."Rent Price";
            AutoRentLine.Quantity := "Rezervation Until" - "Rezervation From";
            AutoRentLine.Description := 'AUTO RENT';
            AutoRentLine.IsCar := true;
            AutoRentLine.Insert();
        end;
    end;

    procedure CountRentDays()
    var
        RentDays: Integer;
        AutoRentLine: Record "Auto Rent Line";
    begin
        RentDays := "Rezervation Until" - "Rezervation From";
        AutoRentLine.SetRange(AutoRentLine."Document No.", "No.");
        if AutoRentLine.FindSet() then
            repeat
                if AutoRentLine.IsCar then begin
                    AutoRentLine.Quantity := RentDays;
                    AutoRentLine.Amount := AutoRentLine.Quantity * AutoRentLine.Price;
                    AutoRentLine.Modify(true);
                end;
            until AutoRentLine.Next() = 0;
    end;

}