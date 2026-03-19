create table Restaurant (
  restaurantID int primary key,
  rest_name varchar(100) not null,
  rest_contact varchar(50),
  rest_adress varchar(200)
);

create table Staff(
  staffID int primary key,
  staff_name varchar(100),
  staff_contNo varchar(20)
);

create table Manager(
  ManagerID int primary key,
  StaffID int not null,
  restaurantID int not null,

  constraint fk_stf 
   foreign key (staffID) 
     references Staff(StaffID),
     
  constraint fk_rest 
    foreign key (restaurantID) 
     references Restaurant(restaurantID)
);

create table Chef(
  chefID int primary key,
  staffID int not null,

  constraint fk_stf_cf
    foreign key (staffID)
     references Staff(staffID)
);


create table Waiter(
  WaiterID int primary key,
  staffID int not null,

  constraint fk_stf_wtr
     foreign key (staffID)
     references Staff(staffID)
);

create table Cashier(
  cashierID int primary key,
  staffID int not null,

  constraint fk_stf_csh
     foreign key (staffID)
     references Staff(staffID)
);


create table Customer(
  customerID int primary key,
  cst_name varchar(100),
  cst_address varchar(200),
  cst_contNo varchar(20)
);



create table Bill(
  billNo int primary key,
  customerID int not null,
  cashierID int not null,
  order_price decimal(10,2) ,
  order_detail varchar(200),

  constraint fk_cst
   foreign key (customerID) 
     references Customer(customerID),
     
  constraint fk_csh
   foreign key (cashierID)
     references Cashier(cashierID),
  
  orderID int references Orders(orderID)
);

create table Orders(
  orderID int primary key,
  no_of_items int,
  waiterID int not null,
  customerID int not null,
  
  constraint fk_wtr_ord
    foreign key (waiterID)
     references Waiter(waiterID),

  constraint fk_cst_ord
   foreign key (customerID) 
     references Customer(customerID)
  
);


create table Item(
  itemID int primary key,
  itemNo int,
  quantity int,
  item_price decimal (10,2),

  orderID int references Orders(orderID)
);


ALTER TABLE Bill
ALTER COLUMN order_price SET DEFAULT 0;

alter table Staff 
alter column staff_contNo set default 009542124586;

alter table bill
add column payment_type varchar(100) check (payment_type in ('cash','card'));

alter table waiter
add column shift varchar(100) check (shift in ('day','night'));

alter table item
add column item_name varchar(100);

ALTER TABLE Item
DROP CONSTRAINT item_orderid_fkey;

ALTER TABLE Item
DROP COLUMN orderID;

insert into Item (itemNo, itemID, quantity, item_price, item_name)
values(1111,0001, 100, 13.50, 'Chicken Burger'),
(1111,0002,78, 20.60, 'Truffle Burger'),
(1111,0003,78, 15.30, 'Hamburger'),
(1111,0004,200, 19.90, 'Pepporoni pizza' ),
(1111,0005,60, 11.90, 'Margarita pizza' ),

(2222,0011, 150, 3.00, 'Ayran'),
(2222,0012, 250, 4.00, 'Cola'),
(2222,0013, 150, 4.00, 'Fanta'),
(2222,0014, 100, 5.50, 'Homemade Lemonade'),
(2222,0015, 500, 1.00, 'Water'),

(3333,0111, 100, 9.00, 'Waffles'),
(3333,0112, 75, 11.50, 'Tiramisu'),
(3333,0113, 120, 11.50, 'Profiterol'),
(3333,0114, 75, 15.90, 'Baklava'),

(4444,0999, 150, 8.90, 'Salad'),
(4444,0998, 50, 8.90, 'Hummus'),
(4444,0997, 250, 6.90, 'Fries'),
(4444,0995, 250, 8.90, 'Mozzeralla Sticks');


insert into restaurant (restaurantid,rest_name, rest_contact, rest_adress)
values
(77586660, 'Anteiku', 009542124586,'20th Ward street');

insert into staff(staffid,staff_name,staff_contno)
values
(01,'Manager',1100),
(02,'Cashier',009542124586),
(03,'Waiter',009542124586),
(04,'Chef',009542124586);

insert into manager (managerid,staffid,restaurantid)
values (111,01,77586660);



insert into customer(customerID,cst_name,cst_address,cst_contNo )
values
(661,'Mustafa','16th street',009533766421),
(662,'Firas','18th street',009533865521),
(663,'Zeynep','17th street',009533298468),
(664,'Hediye','15th street',009533654932);


insert into bill(billNo,customerid,cashierID,order_price,order_detail,orderID)
values
(001,661 ,200, 30.5 ,'Chicken Burger,Homemade Lemonade,Tiramisu',700, ),
(002,662,201, 19.3 ,'Hamburger,Fanta' ,701,),
(003,663,201, 43.4 ,'Truffle Burger,Margarita pizza,Cola,Fries',702,),
(004,664,203, 37.8 ,'Pepporoni pizza,Mozzeralla Sticks,Waffles',703, ),
(005,662,200, 8.90, 'Hummus',704,'cash'),
(006,661,203, 17.5 ,'Fanta,Chicken Burger',705,'card' );

insert into orders(orderID ,no_of_items ,waiterID ,customerID )
values
(700,3,300,661),
(701,2,301,662),
(702,4,303,663),
(703,3,304,664),
(704,1,305,661),
(705,2,306,662);





insert into chef(staffID, chefID)
values
(04,400),
(04,401),
(04,402),
(04,403);

insert into waiter(staffID, waiterID, shift)
values
(03,300,'day'),
(03,301,'night'),
(03,302,'day'),
(03,303,'night'),
(03,304,'day'),
(03,305,'night'),
(03,306,'day'),
(03,307,'night');

insert into cashier(staffID, cashierID)
values
(02,200),
(02,201),
(02,203);


update bill set payment_type='cash' where billNo=001;
update bill set payment_type='card' where billNo=002;
update bill set payment_type='card' where billNo=003;
update bill set payment_type='cash' where billNo=004;
update bill set payment_type='card' where billNo=005;
update bill set payment_type='cash' where billNo=006;

alter table staff
add column salary int; 
update staff set salary= 4000 where staffid=01;
update staff set salary= 1750 where staffid=02;
update staff set salary= 1750 where staffid=03;
update staff set salary= 3500 where staffid=04;


ALTER TABLE Orders 
ADD COLUMN order_date DATE DEFAULT current_date;


update orders set order_date = '2025-12-10' where orderID = 700;
update orders set order_date = '2025-12-11' where orderID = 701;
update orders set order_date= '2025-12-5' where orderid = 702;
update orders set order_date= '2025-12-13' where orderid = 703;
update orders set order_date= '2025-12-2' where orderid = 704;
update orders set order_date= '2025-12-10' where orderid = 705;
