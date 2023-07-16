--  array and struct within array 
BEGIN
        create temp table array_struct_within_array as
        with a as (
        select 101 as emp_id,[ --Begin Address Array
                struct("current" as address_type,"100 Club Street" as street_address, 101 as apartment_number, "12345" as zipcode, 
                        struct("yes" as owner, "no" as tenant) as resident, -- Struct of resident
                        ["3 bedroom","kitchen","living room","garden"] as layout -- Array of Layout
                ),
                struct("previous" as address_type,"200 Players Street" as street_address,null  as apartment_number,"12345" as zipcode, 
                        struct("no" as owner, "yes" as tenant) as resident,
                        ["2 bedroom","kitchen","living room"] as layout
                ),
                struct("birth" as address_type,"300 Tour Pkwy" as street_address,123  as apartment_number,"54321" as zipcode,
                        struct("yes" as owner, "no" as tenant) as resident,
                        ["4 bedroom","kitchen","living room"] as layout
                )
        ]as address) --End Address Array
        select * from a;
END;
 
------------------------------- ACCESSING ARRAY OF STRUCT VALUES -------------------------------
select * from array_struct_within_array;

-- Query an array having array and struct within struct (Array[Struct<Array[],Struct<>])
 select emp_id, address_type,zipcode, resident, layout
        from array_struct_within_array,
        unnest (address) as address,
        unnest ([address.resident]) as resident,
        unnest (layout) as layout
;