CREATE TABLE USER_TABLE (
USER_ID VARCHAR(7)PRIMARY KEY,
USER_NAME VARCHAR(23),
EMAIL VARCHAR(23)CONSTRAINT not_an_email CHECK(EMAIL LIKE '%@%'),
PASS VARCHAR(23),
DATE_OF_REG DATE,
ADDRESS VARCHAR(100),
CONTACT_NUM VARCHAR(11)
)

create sequence auto_increment_user_id start with 1;

-- ADD TRIGGER TO AUTO GENERATE USER ID
create trigger trg_auto_user_id 
       before insert on USER_TABLE
       for each row
begin
   select 'U'||trim(to_char(auto_increment_user_id.nextval, '00099'))
         into :new.USER_ID
         from dual;
end;


CREATE TABLE ADMIN_TABLE (
ADMIN_ID VARCHAR(7)PRIMARY KEY,
EMAIL VARCHAR(23)CONSTRAINT email_val_Admin CHECK(EMAIL LIKE '%@%'),
PASS VARCHAR(23)
)



-- ADD TRIGGER TO AUTO GENERATE ADMIN ID
create sequence auto_increment_adminn_id start with 1;
create trigger trg_auto_admin_id 
       before insert on ADMIN_TABLE
       for each row
begin
   select 'A'||trim(to_char(auto_increment_adminn_id.nextval, '00099'))
         into :new.ADMIN_ID
         from dual;
end;


CREATE TABLE CATEGORY_TABLE (
CATEGORY_ID VARCHAR(7)PRIMARY KEY,
CATEGORY_NAME VARCHAR(23)
)

-- ADD TRIGGER TO AUTO GENERATE CATEGORY ID
create sequence auto_increment_cat_id start with 1;
create trigger trg_auto_cat_id 
       before insert on CATEGORY_TABLE
       for each row
begin
   select 'C' || trim(to_char(auto_increment_cat_id.nextval, '00099'))
         into :new.CATEGORY_ID
         from dual;
end;

CREATE TABLE PRODUCT_TABLE (
PRODUCT_ID VARCHAR(7)PRIMARY KEY,
PRODUCT_NAME VARCHAR(23),
CATEGORY_ID VARCHAR(6) REFERENCES CATEGORY_TABLE(CATEGORY_ID),
PRODUCT_PRICE NUMBER(8,2),
PRODUCT_IMAGE VARCHAR2(23),
PRODUCT_AVAILABLE_QTY NUMBER
)

-- ADD TRIGGER TO AUTO GENERATE PRODUCT_ID
create sequence auto_increment_prod_id start with 1;
create trigger trg_auto_prod_id 
       before insert on PRODUCT_TABLE
       for each row
begin
   select 'P'||trim(to_char(auto_increment_prod_id.nextval, '00099'))
         into :new.PRODUCT_ID
         from dual;
end;

CREATE TABLE CART_TABLE (
CART_ID VARCHAR(7)PRIMARY KEY,
USER_ID VARCHAR(7)REFERENCES USER_TABLE(USER_ID)
)
-- ADD TRIGGER TO AUTO GENERATE CART_ID
create sequence auto_increment_cart_id start with 1;

create trigger trg_auto_cart_id 
       before insert on CART_TABLE
       for each row
begin
   select 'CT'||trim(to_char(auto_increment_cart_id.nextval, '00099'))
         into :new.CART_ID
         from dual;
end;

CREATE TABLE CART_ITEMS_TABLE (
CART_ID VARCHAR(7)REFERENCES CART_TABLE(CART_ID),
USER_ID VARCHAR(7)REFERENCES USER_TABLE(USER_ID),
PRODUCT_ID VARCHAR(7) REFERENCES PRODUCT_TABLE(PRODUCT_ID),
PRODUCT_QTY VARCHAR(5)
)

CREATE TABLE COUPON_TABLE (
COUPON_ID VARCHAR(7) PRIMARY KEY,
COUPON_NAME VARCHAR(23),
DISCOUNT_VAL NUMBER(8,2),
EXP_DATE DATE
)

-- ADD TRIGGER TO AUTO GENERATE COUPON_ID
create sequence auto_increment_coupon_id start with 1;

create trigger trg_auto_coupon_id  
       before insert on COUPON_TABLE
       for each row
begin
   select 'CP'||trim(to_char(auto_increment_coupon_id.nextval, '00099'))
         into :new.COUPON_ID
         from dual;
end;

CREATE TABLE ORDER_TABLE (
ORDER_ID VARCHAR(7)PRIMARY KEY,
CART_ID VARCHAR(7)REFERENCES CART_TABLE(CART_ID),
USER_ID VARCHAR(7)REFERENCES USER_TABLE(USER_ID),
ORDER_DATE DATE DEFAULT SYSDATE NOT NULL,
DELIVERY_DATE DATE DEFAULT SYSDATE + 7,
COUPON_ID VARCHAR(7),
BILL_AMOUNT NUMBER,
PAYMENT_METHOD VARCHAR(23) CONSTRAINT PM_CHECK CHECK(LOWER(PAYMENT_METHOD)IN('cod', 'debit/credit card', 'online wallet'))
)

-- ADD TRIGGER TO AUTO GENERATE ORDER_ID

create sequence auto_increment_order_id start with 1;

create trigger trg_auto_order_id 
       before insert on ORDER_TABLE
       for each row
begin
   select 'O'||trim(to_char(auto_increment_order_id.nextval, '00099'))
         into :new.ORDER_ID
         from dual;
end;

