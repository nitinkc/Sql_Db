-- MERGE -- If data exist then do update else insert.
select * from medical_records;
select * from medical_records_history; -- initially History table does not exist

drop table if exists medical_records_history;

-- Creating tables from existing table, if exist
CREATE TABLE MEDICAL_RECORDS_HISTORY
AS SELECT * FROM MEDICAL_RECORDS
WHERE 1 = 2; -- COLUMN 1 OF MEDICAL_RECORDS IS SAME AS COLUMN 2 OF HISTORY TABLE

merge INTO
	MEDICAL_RECORDS_HISTORY Hist
		USING MEDICAL_RECORDS M ON
	M.ID = Hist.ID
	WHEN MATCHED THEN
	UPDATE
SET
PROBLEM = M.PROBLEM
WHEN NOT MATCHED THEN 
	insert (ID, PROBLEM, DATE_OF_EXAMINATION, PATIENT_ID, DOCTOR_ID)
	VALUES(M.ID, M.PROBLEM, M.DATE_OF_EXAMINATION, M.PATIENT_ID, M.DOCTOR_ID);

-- TODO: Whenever update of main table happens, the corrosponding Hist table should also be udpated
update medical_records
set problem='covid'
where id=2;
