table 70104 "Auto Reservation"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(20; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(30; "Reservation From"; Date)
        {
            Caption = 'Reservation From';
            DataClassification = ToBeClassified;
        }
        field(40; "Reservation Until"; Date)
        {
            Caption = 'Reservation Until';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }
}