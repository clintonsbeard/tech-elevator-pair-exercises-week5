-- We noticed that the same procedure on the invoice had two different prices, so
-- we assumed that there were different prices for the same procedure on different
-- types of animals.

-- We also assumed that total = subtotal * tax.

DROP TABLE IF EXISTS invoice_location;
DROP TABLE IF EXISTS procedure_visit;
DROP TABLE IF EXISTS pet_visit;
DROP TABLE IF EXISTS pet_procedure;
DROP TABLE IF EXISTS invoice_procedure;
DROP TABLE IF EXISTS pet_owner;
DROP TABLE IF EXISTS owner_address;
DROP TABLE IF EXISTS invoice_owner;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS visit;
DROP TABLE IF EXISTS procedure;
DROP TABLE IF EXISTS pet;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS owner;
DROP TABLE IF EXISTS invoice;

SELECT * FROM owner;
SELECT * FROM invoice;

CREATE TABLE invoice
(
        invoice_id serial primary key,
        date_added timestamp not null,
        date_updated timestamp,
        subtotal decimal(10) not null,
        total decimal(10) not null
);

CREATE TABLE owner
(
        owner_id serial primary key,
        first_name varchar(100) not null,
        last_name varchar(100) not null,
        date_added timestamp not null,
        date_updated timestamp
);

CREATE TABLE address
(
        address_id serial primary key,
        street_address varchar(255) not null,
        street_address2 varchar(255),
        city varchar(100) not null,
        district varchar(255) not null,
        postal_code varchar(25) not null,
        country_code char(3)
);

CREATE TABLE pet
(
        pet_id serial primary key,
        first_name varchar(100) not null,
        pet_type varchar(100) not null,
        pet_age integer not null check (pet_age between 0 and 50)
        
        constraint chk_pet_type CHECK (pet_type IN ('Feline', 'Canine', 'Reptile', 'Avian', 'Small Animal', 'Exotic'))
);

CREATE TABLE procedure
(
        procedure_id serial primary key,
        name varchar(100) not null,
        amount decimal(10) not null
);

CREATE TABLE visit
(
        visit_id serial primary key,
        date timestamp not null
);

CREATE TABLE location
(
        location_id serial primary key,
        name varchar(100) not null,
        street_address varchar(255) not null,
        street_address2 varchar(255),
        city varchar(100) not null,
        district varchar(255) not null,
        postal_code varchar(25) not null,
        country_code char(3),
        tax_rate decimal(5) not null
);

CREATE TABLE invoice_owner
(
        invoice_id int not null,
        owner_id int not null,
        
        constraint fk_invoice_owner_invoice_id foreign key (invoice_id) references invoice (invoice_id),
        constraint fk_invoice_owner_owner_id foreign key (owner_id) references owner (owner_id)
);

CREATE TABLE owner_address
(
        owner_id int not null,
        address_id int not null,
        
        constraint fk_owner_address_owner_id foreign key (owner_id) references owner (owner_id),
        constraint fk_owner_address_address_id foreign key (address_id) references address (address_id)
);

CREATE TABLE pet_owner
(
        pet_id int not null,
        owner_id int not null,
        
        constraint fk_pet_owner_pet_id foreign key (pet_id) references pet (pet_id),
        constraint fk_pet_owner_owner_id foreign key (owner_id) references owner (owner_id)
);

CREATE TABLE invoice_procedure
(
        invoice_id int not null,
        procedure_id int not null,
        
        constraint fk_invoice_procedure_invoice_id foreign key (invoice_id) references invoice (invoice_id),
        constraint fk_invoice_procedure_procedure_id foreign key (procedure_id) references procedure (procedure_id)
);

CREATE TABLE pet_procedure
(
        pet_id int not null,
        procedure_id int not null,
        
        constraint fk_pet_procedure_pet_id foreign key (pet_id) references pet (pet_id),
        constraint fk_pet_procedure_procedure_id foreign key (procedure_id) references procedure (procedure_id)
);

CREATE TABLE pet_visit
(
        pet_id int not null,
        visit_id int not null,
        
        constraint fk_pet_visit_pet_id foreign key (pet_id) references pet (pet_id),
        constraint fk_pet_visit_visit_id foreign key (visit_id) references visit (visit_id)
);

CREATE TABLE procedure_visit
(
        procedure_id int not null,
        visit_id int not null,
        
        constraint fk_procedure_procedure_id foreign key (procedure_id) references procedure (procedure_id),
        constraint fk_procedure_visit_id foreign key (visit_id) references visit (visit_id)
);

CREATE TABLE invoice_location
(
        invoice_id int not null,
        location_id int not null,
        
        constraint fk_invoice_location_invoice_id foreign key (invoice_id) references invoice (invoice_id),
        constraint fk_invoice_location_location_id foreign key (location_id) references location (location_id)
);