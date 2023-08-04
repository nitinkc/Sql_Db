-- https://livesql.oracle.com/apex/livesql/s/ehp513e07ul4b1gvnthjoxzd

drop table accounts;
drop table transactions;
drop sequence transaction_seq;

CREATE SEQUENCE transaction_seq;
-- Create the "accounts" table
CREATE TABLE accounts (
  account_id NUMBER PRIMARY KEY,
  balance NUMBER
);

-- Create the "transactions" table
CREATE TABLE transactions (
  transaction_id NUMBER PRIMARY KEY,
  account_id NUMBER,
  amount NUMBER,
  transaction_type VARCHAR2(10),
  transaction_date DATE,
  CONSTRAINT fk_account FOREIGN KEY (account_id) REFERENCES accounts (account_id)
);

INSERT INTO accounts (ACCOUNT_ID, balance) VALUES (1001, 5000);
INSERT INTO accounts (ACCOUNT_ID, balance) VALUES (1002, 6000);

select
    "ACCOUNT_ID",
    "BALANCE"
from "ACCOUNTS";

-- Sample PL/SQL block for a money transfer transaction
DECLARE
  sender_account NUMBER := 1001;
  receiver_account NUMBER := 1002;
  amount_to_transfer NUMBER := 100;
  remaining_balance_sender NUMBER;
  remaining_balance_receiver NUMBER;
BEGIN -- Start the transaction
  BEGIN
    -- Deduct money from the sender's account
    UPDATE accounts
    SET balance = balance - amount_to_transfer
    WHERE account_id = sender_account
    RETURNING balance INTO remaining_balance_sender;

	amount_to_transfer := amount_to_transfer/0; --Simulating errors
    -- Add money to the receiver's account
    UPDATE accounts
    SET balance = balance + amount_to_transfer
    WHERE account_id = receiver_account
    RETURNING balance INTO remaining_balance_receiver;

    -- Insert transaction details into the "transactions" table
    INSERT INTO transactions (transaction_id, account_id, amount, transaction_type, transaction_date)
    VALUES (transaction_seq.nextval, sender_account, amount_to_transfer, 'DEBIT', SYSDATE);

    INSERT INTO transactions (transaction_id, account_id, amount, transaction_type, transaction_date)
    VALUES (transaction_seq.nextval, receiver_account, amount_to_transfer, 'CREDIT', SYSDATE);

    -- Commit the transaction
    COMMIT;
  EXCEPTION
    -- If an error occurs, rollback the transaction
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
  END;

  -- Display remaining balances after the transaction
  DBMS_OUTPUT.PUT_LINE('Remaining Balance in Sender Account: ' || remaining_balance_sender);
  DBMS_OUTPUT.PUT_LINE('Remaining Balance in Receiver Account: ' || remaining_balance_receiver);
END;

select
    "ACCOUNT_ID",
    "BALANCE"
from "ACCOUNTS";

select * from transactions;
