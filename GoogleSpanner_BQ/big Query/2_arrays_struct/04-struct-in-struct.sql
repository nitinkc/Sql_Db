-- Create Struct within a struct within a Master Array
BEGIN
    create temp table array_of_struct_within_struct_demo as
    with a as (
    select 101 as emp_id, 
    [ --Array Of address
        struct("current" as address_type,"100 Club Street" as street_address, 101 as apartment_number, "12345" as zipcode, 
            struct("yes" as owner, "no" as tenant) as resident --Struct within a struct
        ),
        struct("previous" as address_type,"200 Players Street" as street_address,null  as apartment_number,"12345" as zipcode, 
            struct("no" as owner, "yes" as tenant) as resident
        ),
        struct("birth" as address_type,"300 Tour Pkwy" as street_address,123  as apartment_number,"54321" as zipcode,
            struct("yes" as owner, "no" as tenant) as resident)
    ]as address
    )
    select * from a;

END;
  
------------------------------- ACCESSING ARRAY OF STRUCT VALUES -------------------------------

SELECT * from array_of_struct_within_struct_demo;

-- Query an array having struct within another struct (Array[Struct<columns,Struct<>])

-- Select the address of the residence along with address type
SELECT emp_id, 
        unnested_address.address_type,
        IF (LOWER(resident.owner) = LOWER("Yes") , "owner", "tenant") as resident_type,
        unnested_address.street_address,
        unnested_address.apartment_number,
        unnested_address.zipcode,
FROM
  array_of_struct_within_struct_demo AS addrAlias,
  UNNEST(addrAlias.address) AS unnested_address, --First unnest Address Array
  UNNEST([unnested_address.resident]) AS resident --Then, unnest resident structure within Address array 
;
