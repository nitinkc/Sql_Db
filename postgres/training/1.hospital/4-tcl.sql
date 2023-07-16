select * from hospitals;

delete from hospitals where hospital_code > 3;
delete from hospitals where hospital_code = 50;

rollback;

commit;

insert into hospitals values (5, 'Fortis Hospital', 'Bangalore', 9900099000);
savepoint record_1;

insert into hospitals values (6, 'Fortis Hospital', 'Bangalore', 9900099000);
savepoint record_2;

insert into hospitals values (7, 'Fortis Hospital', 'Bangalore', 9900099000);
savepoint record_3;

insert into hospitals values (8, 'Fortis Hospital', 'Bangalore', 9900099000);
savepoint record_4;

rollback to record_3;