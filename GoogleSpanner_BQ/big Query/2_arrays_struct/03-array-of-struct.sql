-- Create Array of Struct (RECORD REPEATED)
BEGIN
        create temp table array_of_struct_demo as
        with a as (
        select "101" as emp_id, 
        [-- Array of address, each address is a struct
                struct("current" as address_type,"100 Club Street" as street_address, 101 as apartment_number, "12345" as zipcode),
                struct("previous" as address_type,"200 Players Street" as street_address,null  as apartment_number,"12345" as zipcode),
                struct("birth" as address_type,"300 Tour Pkwy" as street_address,123  as apartment_number,"54321" as zipcode)
        ]as address
        )
        select * from a;
END;

------------------------------- ACCESSING ARRAY OF STRUCT VALUES -------------------------------
  
select * from array_of_struct_demo;

-- select few column keys from array_of_structs with unnest
select emp_id,address_alias.address_type, address_alias.zipcode, --create a user defines struct as per the requirement
        struct(address_alias.street_address as st_addr, 
                IFNULL(CAST(address_alias.apartment_number as STRING), "NO APT NUMBER") as apt, --if Apartment number is NULL, then send user defined string
                address_alias.zipcode as zip 
        ) as address_struct
from array_of_struct_demo,
unnest(address) as address_alias;
