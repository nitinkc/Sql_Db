----------------------------------------------
-- DDL STATEMENTS ----------------------------

/* Column Level Constraints, Unnamed
    *** Can only be applied to one column
*/
Create table tab_1 (c number Primary Key,
First_Name char(30) NOT NULL,
Mobile_Number number(12) UNIQUE,
Gender char(1) Check(gender in ('M','F')));
commit;

/* Table Level Constraints, 
    *** can be applied to a group of columns
    *** have named constraints
    *** maintenance of named constraints is easier than un-nmaed
*/
create table tab_2 (id number(5), name char(20), price number(10),
constraint tab2_id_primary_key PRIMARY KEY(id));
commit;

/* Create a new Table*/
create table tab_3 (name char(20), price number(10));

/* Add column id to the table tab_1*/
alter table tab_3 
add id number;
commit;

/* Add aconstraint */
alter table tab_3 add constraint pk_tab1_id primary key(id);

/* Adding Foreign Key */
alter table tab_3 
add constraints fk_tab2
foreign key (id)
references tab_2(id);

/* Drop the contraint*/
alter table tab_3 
drop constraint fk_tab2;