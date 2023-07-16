--SET @@dataset_project_id = 'my-db-id';
--SET @@dataset_id = '_scriptcae5d106c942abf8c0ad1ef46f5f8dcbedac27b9';

------------------------------- RUN TEMP TABLE IN A SESSION -------------------------------
-- Set MORE -> Query Settings -> Use Session Mode (checked)
-- Set MORE -> Query Settings -> Use Session Mode (checked)


-- Create table defining arrays and structs as data types
BEGIN
create temp table complex_tbl (
        test_array  ARRAY<INT64>, --col1
        test_struct STRUCT<col1 INT64, col2 STRING, col3 Bool>, --col2
        test_array_of_struct ARRAY<STRUCT<col1 INT64, col2 STRING >>, --col3
        test_struct_in_struct STRUCT<col1 STRUCT<col1_1 INT64, col1_2 STRING>, col2 STRING>, -- col4 is a struct
        test_array_of_nested_structs ARRAY<STRUCT<col1 STRUCT<col1_1 INT64, col1_2 STRING>, col2 STRING>> --col5
);
END;


INSERT INTO complex_tbl values 
(
        [1,2,3,4,5],-- Col 1 Array
        STRUCT(1, "Test", true),-- Col 2 Struct
        -- Col 3 Array of Struct
        [
                STRUCT(101, "John Doe"),
                STRUCT(102, "Jane Doe"),
                STRUCT(101, "Tic tac toe "),
                STRUCT(101, "Ronald McDonalds")                
        ], 
        -- Col 4 Struct of Struct
        STRUCT(
          STRUCT(901, "John Doe"), "Struct Test1"
        ),
        [ -- col5 Array of Struct
          STRUCT(STRUCT(1001, "John Doe"), "Array Element1"),
          STRUCT(STRUCT(1101, "John Doe"), "Array Element2"),
          STRUCT(STRUCT(1201, "John Doe"), "Array Element3")
        ]        
),
(
        [9,8,7,6,5,4,3],-- Col 1 Array
        STRUCT(1, "Test", true),-- Col 2 Struct
        -- Col 3 Array of Struct
        [
                STRUCT(101, "John Doe"),
                STRUCT(101, "Ronald McDonalds")                
        ], 
        -- Col 4 Struct of Struct
        STRUCT(
          STRUCT(901, "John Doe"), "Struct Test1"
        ),
        [ -- col5 Array of Struct
          STRUCT(STRUCT(1001, "John Doe"), "Array Element1"),
          STRUCT(STRUCT(1101, "Jane Doe"), "Array Element2"),
          STRUCT(STRUCT(1201, "Tic tac toe"), "Array Element3")
        ]        
)
;

------------------------------- ACCESSING COMPLEX TABLE -------------------------------

-- Query the complex Table
SELECT * from array_struct_tbl;

