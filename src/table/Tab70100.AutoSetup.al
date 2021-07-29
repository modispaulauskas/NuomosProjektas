table 70100 "Auto Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary key"; Integer)
        {
            Caption = 'Primary key';
            DataClassification = ToBeClassified;
        }
        field(10; "Auto Nos."; Code[20])
        {
            Caption = 'Auto Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(20; "Rent Card Nos."; Code[20])
        {
            Caption = 'Rent Card Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(30; "Accessories Place"; Code[20])
        {
            Caption = 'Accessories Place';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary key")
        {
            Clustered = true;
        }
    }
    procedure InsertIfNotExist()
    begin
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;
}