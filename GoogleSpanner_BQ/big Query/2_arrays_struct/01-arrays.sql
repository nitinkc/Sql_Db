BEGIN
        -- Create Array (REPEATED)
        create temp table array_demo as
        with a as (
        select "101" as emp_id, 
        ["current", "previous", "office"] as address_type --Array of address
        )
        select emp_id, address_type from a;

        insert into array_demo values
        ("102", ["current","previous"]),
        ("103", ["current","office","previous"])
        ;
END;


------------------------------- ACCESSING ARRAY(REPEATED) VALUES -------------------------------

select * from array_demo;

-- Query Array (REPEATED) as multiple rows with unnest
select emp_id, address_type as Type_of_address from array_demo,
unnest (address_type) as address_type;--unnest splits the contents of the array and presents each element as a single row,

--unnest (address_type) as address_type;--Check Why this one gives weird answers