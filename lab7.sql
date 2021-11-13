create table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');

--1
You can use large object data types to store audio, video, images, and other files that are larger than 32 KB.

 For data objects that are larger than 32 KB, you can use the corresponding large object (LOB) data types to store these objects.

Db2 provides three data types to store these data objects as strings of up to 2 GB in size:
Character large objects (CLOBs)
Use the CLOB data type to store SBCS or mixed data, such as documents that contain single character set. Use this data type if your data is larger (or might grow larger) than the VARCHAR data type permits.
Double-byte character large objects (DBCLOBs)
Use the DBCLOB data type to store large amounts of DBCS data, such as documents that use a DBCS character set.
Binary large objects (BLOBs)
Use the BLOB data type to store large amounts of noncharacter data, such as pictures, voice, and mixed media.


    --2
create role accountant
create role administrator
create role support
create user Director
grant administrator to Director
create user deputy_accountant
grant accountant to  deputy_accountant
create user intern
grant support to intern
revoke deputy_accountant from accountant
revoke intern from support




--3.2
ALTER TABLE customers ALTER COLUMN birth_date SET NOT NULL


--5
create unique index ind1 on accounts(account_id);
create index ind2 on accounts (currency,balance);



--6
begin TRANSACTION
update accounts
set balance=ac.balance+500
from accounts ac, transactions tr
where ac.account_id=tr.dst_account
savepoint save
update accounts
set balance=ac.balance-500
from accounts ac, transactions tr
where ac.account_id=tr.dst_account and ac.balance-500>accounts.limit
rollback

commit



