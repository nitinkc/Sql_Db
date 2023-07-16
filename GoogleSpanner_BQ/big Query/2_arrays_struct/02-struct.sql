-- Create Struct (RECORD)
BEGIN
    create temp table struct_demo as
    with a as (
    select 101 as emp_id, 
    struct("current" as address_type,"100 Club Street" as street_address, 101 as apartment_number, "12345" as zipcode) as address
    )
    select * from a;

    insert into struct_demo values
    (101,STRUCT("office","200 Players Street",null,"12345")),
    (101,STRUCT("previous","300 Tour Pkwy",123,"54321")),
    (101,STRUCT("birth","400 Team Street", 4567,"98765"))
;
END;

------------------------------- ACCESSING STRUCT VALUES -------------------------------

select * from struct_demo;

-- Query few keys from Struct (RECORD)
select emp_id,address.address_type, address.street_address
from struct_demo;