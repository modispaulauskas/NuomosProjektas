table 70103 "Auto"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Auto Name"; Text[30])
        {
            Caption = 'Auto Name';
            DataClassification = ToBeClassified;
        }

        field(20; "Auto Mark"; Code[20])
        {
            Caption = 'Auto Mark';
            DataClassification = ToBeClassified;
        }

        field(30; "Auto Model"; Code[20])
        {
            Caption = 'Auto Model';
            DataClassification = ToBeClassified;
            TableRelation = "Auto Model" where("Auto Code" = field("Auto Mark"));
        }
        field(40; "Make Year"; Date)
        {
            Caption = 'Make Year';
            DataClassification = ToBeClassified;
        }

        field(50; "Civil Insurance Until"; Date)
        {
            Caption = 'Civil Insurance Until';
            DataClassification = ToBeClassified;
        }

        field(60; "Technical Validity Until"; Date)
        {
            Caption = 'Technical Validity Until';
            DataClassification = ToBeClassified;
        }

        field(70; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }

        field(80; "Rent Service"; Code[20])
        {
            Caption = 'Rent Service';
            DataClassification = ToBeClassified;
            TableRelation = Resource;
        }

        field(90; "Rent Price"; Decimal)
        {
            Caption = 'Rent Price';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Resource."Unit Price" where("No." = field("Rent Service")));
        }

    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Auto Name", "Auto Mark", "Auto Model")
        {

        }
    }
    procedure GetAutoNoFromNoSeries(): Code[20]
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        AutoSetup.Get();
        AutoSetup.TestField("Auto Nos.");

        exit(NoSeriesManagement.GetNextNo(AutoSetup."Auto Nos.", WorkDate(), true));
    end;
}