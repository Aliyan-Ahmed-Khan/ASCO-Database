create table Provider(
  provider_id int identity(1,1) primary key,
  provider_name varchar(30),
  provider_contact varchar(11)
)

insert into Provider (provider_name,provider_contact) values 
                     ('Hira Raheel','01234567890'),
					 ('Aliyan Khan','10234567803'),
					 ('Rahim Shah','09837289376'),
					 ('Zainab Raheel','0927836512')

create table Farmer(
  farmer_id int identity(1,1) primary key,
  farmer_name varchar(20),
  farmer_address varchar(30),
  farmer_contact varchar(11),
  farmer_password varchar(50)
)

insert into Farmer (farmer_name,farmer_address,farmer_contact,farmer_password) values 
                   ('Jameel','Sargodha','01234567890','pass1'),
				   ('Ahmed','Mianwali','01985107090','pass2'),
				   ('Ali','Chakwal','01234091270','pass3'),
				   ('Majid','Multan','01234567890','pass4')

create table Tool(
  tool_id int identity(1,1) primary key,
  tool_name varchar(11) CHECK (tool_name IN ('Axe','Rake','Shovel','Wheelbarrow')),
  tool_manufacturer varchar(50),
  tool_quantity int,
  CONSTRAINT UQ_ToolName UNIQUE (tool_name) 
)

INSERT INTO Tool (tool_name, tool_manufacturer, tool_quantity) VALUES 
                 ('Axe', 'Sarina Enterprises', 50),
                 ('Rake', 'Malik Agro Industries', 50),
                 ('Shovel', 'Millat Equipment Limited', 50),
                 ('Wheelbarrow', 'Pakistan Agro Industries', 50);

create table Farmer_Tool_RS(
    relationship_id int identity(1,1) primary key,
    farmer_id int,
    tool_id int,
    FOREIGN KEY (farmer_id) REFERENCES Farmer(farmer_id),
    FOREIGN KEY (tool_id) REFERENCES Tool(tool_id),
	tool_takendate date,
    not_valid_until AS CAST(DATEADD(MONTH, 6, GETDATE()) AS DATE),
	CONSTRAINT UC_Farmer_Tool UNIQUE (farmer_id)
)

insert into Farmer_Tool_RS (farmer_id, tool_id,tool_takendate) values 
                     (1,1,getdate()),
					 (2,2,getdate()),
					 (3,3,getdate())

CREATE TABLE Machinery(
    machinery_id int identity(1,1) primary key,
    machinery_type varchar(20) CHECK (machinery_type IN ('Tractor', 'Wagon', 'Cultivator')),
    machine_manufacturer varchar(50),
	machinery_quantity int,
	CONSTRAINT UQ_MachineryType UNIQUE (machinery_type)
)

INSERT INTO Machinery (machinery_type,machine_manufacturer, machinery_quantity) VALUES 
					  ('Tractor','Manufacter1', 50),
					  ('Wagon', 'Manufacter2', 50),
					  ('Cultivator','Manufacter3', 50);

CREATE TABLE Farmer_Machinery_RS(
    relationship_id int identity(1,1) primary key,
    farmer_id int,
    machinery_id int,
    FOREIGN KEY (farmer_id) REFERENCES Farmer(farmer_id),
    FOREIGN KEY (machinery_id) REFERENCES Machinery(machinery_id),
	machinery_takendate date,
    not_valid_until AS CAST(DATEADD(MONTH, 6, GETDATE()) AS DATE),
	CONSTRAINT UC_Farmer_Machinery UNIQUE (farmer_id)
)

insert into Farmer_Machinery_RS (farmer_id,machinery_id,machinery_takendate) values 
				(1,1,getdate()),
				(2,1,getdate()),
				(3,2,getdate())


create table Seed(
  seed_id int identity(1,1) primary key,
  seed_name varchar(20),
  seed_company varchar(50),
  seed_quality varchar(10),
  CONSTRAINT UQ_SeedType UNIQUE (seed_name)  
)

insert into Seed (seed_name,seed_company,seed_quality) values 
                 ('Wheat', 'Qureshi Seed Corporation', 'High'),
				 ('Rice', 'Allied Seed Corporation', 'Medium'),
			     ('Corn', 'Punjab Seed Corporation', 'Low'),
			     ('Barley', 'Monsanto Pakistan ', 'High')

CREATE TABLE Farmer_Seed_RS(
    relationship_id int identity(1,1) primary key,
    farmer_id int,
    seed_id int,
    FOREIGN KEY (farmer_id) REFERENCES Farmer(farmer_id),
    FOREIGN KEY (seed_id) REFERENCES Seed(seed_id),
	seed_takendate date,
    not_valid_until AS CAST(DATEADD(MONTH, 6, GETDATE()) AS DATE),
	CONSTRAINT UC_Farmer_Seed UNIQUE (farmer_id)
)

insert into Farmer_Seed_RS (farmer_id,seed_id,seed_takendate) values 
						   (1,3,getdate()),
						   (3,2,getdate()),
						   (2,2,getdate())

create table Fertilizer(
  fertilizer_id int identity(1,1) primary key,
  fertilizer_name varchar(20),
  fertilizer_company varchar(50),
  fertilizer_quality varchar(10),
  CONSTRAINT UQ_FertilizerType UNIQUE (fertilizer_name)
)

insert into Fertilizer (fertilizer_name,fertilizer_company,fertilizer_quality) values 
					   ('Nitrogen', 'Engro Fertilizers Limited', 'High'),
			       	   ('Phosphorus', 'Fauji Fertilizer Company Limited', 'Medium'),
					   ('Potassium', 'Agritech Limited', 'Low');

CREATE TABLE Farmer_Fertilizer_RS (
    relationship_id int identity(1,1) primary key,
    farmer_id int,
    fertilizer_id int,
    FOREIGN KEY (farmer_id) REFERENCES Farmer(farmer_id),
    FOREIGN KEY (fertilizer_id) REFERENCES Fertilizer(fertilizer_id),
    fertilizer_takendate date,
    not_valid_until AS CAST(DATEADD(MONTH, 6, GETDATE()) AS DATE),
	CONSTRAINT UC_Farmer_Fertilizer UNIQUE (farmer_id)
)

insert into Farmer_Fertilizer_RS (farmer_id,fertilizer_id,fertilizer_takendate) values 
								(2,1,getdate()),
								(3,1,getdate()),
								(1,2,getdate())

CREATE TABLE Loan(
   loan_id int identity(1,1) primary key,
   loan_amount int,
   CONSTRAINT CHK_LoanAmount CHECK (loan_amount >= 5000 AND loan_amount <= 50000),
   status varchar(50)
)

insert into Loan (loan_amount,status) values 
                     (10000,'Pending'),
					 (15000,'Pending'),
					 (20000,'Pending')

create table Farmer_Loan_RS(
    relationship_id int identity(1,1) primary key,
    farmer_id int,
    loan_id int,
    FOREIGN KEY (farmer_id) REFERENCES Farmer(farmer_id),
    FOREIGN KEY (loan_id) REFERENCES Loan(loan_id),
	loan_takendate date,
    not_valid_until AS CAST(DATEADD(MONTH, 6, GETDATE()) AS DATE),
	CONSTRAINT UC_Farmer_Loan UNIQUE (farmer_id)
)

insert into Farmer_Loan_RS (farmer_id, loan_id,loan_takendate) values 
						   (1,1,getdate()),
						   (2,2,getdate()),
						   (3,3,getdate())

CREATE TABLE Admin(
		admin_id int identity(1,1) primary key,
		admin_name varchar(20),
		admin_pass varchar(50)
)

INSERT INTO Admin (admin_name, admin_pass) VALUES 
				  ('hira', 'adminpassword1'),
		          ('aliyan', 'adminpassword2')

--Triggers 
CREATE TRIGGER trg_DecrementToolQuantity
ON Farmer_Tool_RS
AFTER INSERT
AS BEGIN
    UPDATE Tool
    SET tool_quantity = tool_quantity - 1
    FROM Tool t
    JOIN inserted i ON t.tool_id = i.tool_id
    WHERE t.tool_quantity > 0;

    -- Ensure quantity does not go negative
    IF EXISTS (SELECT 1 FROM Tool WHERE tool_quantity < 0)
    BEGIN
        RAISERROR('Tool quantity cannot be less than zero.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END


CREATE TRIGGER trg_DecrementMachineryQuantity
ON Farmer_Machinery_RS
AFTER INSERT
AS BEGIN
    UPDATE Machinery
    SET machinery_quantity = machinery_quantity - 1
    FROM Machinery m
    JOIN inserted i ON m.machinery_id = i.machinery_id
    WHERE m.machinery_quantity > 0;

    IF EXISTS (SELECT 1 FROM Machinery WHERE machinery_quantity < 0)
    BEGIN
        RAISERROR('Machinery quantity cannot be less than zero.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END

CREATE TRIGGER trg_DecrementSeedQuantity
ON Farmer_Seed_RS
AFTER INSERT
AS BEGIN
    UPDATE Seed
    SET seed_quantity = seed_quantity - 1
    FROM Seed s
    JOIN inserted i ON s.seed_id = i.seed_id
    WHERE s.seed_quantity > 0;

    IF EXISTS (SELECT 1 FROM Seed WHERE seed_quantity < 0)
    BEGIN
        RAISERROR('Seed quantity cannot be less than zero.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

CREATE TRIGGER trg_DecrementFertilizerQuantity
ON Farmer_Fertilizer_RS
AFTER INSERT
AS BEGIN
    UPDATE Fertilizer
    SET fertilizer_quantity = fertilizer_quantity - 1
    FROM Fertilizer f
    JOIN inserted i ON f.fertilizer_id = i.fertilizer_id
    WHERE f.fertilizer_quantity > 0;

    IF EXISTS (SELECT 1 FROM Fertilizer WHERE fertilizer_quantity < 0)
    BEGIN
        RAISERROR('Fertilizer quantity cannot be less than zero.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END

CREATE TRIGGER trg_InsertFarmer
ON Farmer
AFTER INSERT
AS BEGIN
    PRINT 'New Farmer record inserted.'
END

CREATE TRIGGER trg_UpdateFarmer
ON Farmer
AFTER UPDATE
AS BEGIN
    PRINT 'Farmer record updated.'
END

CREATE TRIGGER trg_DeleteFarmer
ON Farmer
AFTER DELETE
AS BEGIN
    PRINT 'Farmer record deleted.'
END

CREATE TRIGGER trg_InsertTool
ON Tool
AFTER INSERT
AS BEGIN
    PRINT 'New Tool record inserted.'
END

CREATE TRIGGER trg_DeleteTool
ON Tool
AFTER DELETE
AS BEGIN
    PRINT 'Tool record deleted.'
END

CREATE TRIGGER trg_UpdateTool
ON Tool
AFTER UPDATE
AS BEGIN
    PRINT 'Tool record updated.'
END


CREATE TABLE FertilizerAuditTrail (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    ActionType VARCHAR(255),
    fertilizer_id INT,
    TimeStamp DATETIME
)

CREATE TRIGGER insertFertilizer
ON Fertilizer
AFTER INSERT
AS BEGIN
    INSERT INTO FertilizerAuditTrail (ActionType, fertilizer_id, TimeStamp)
    SELECT 'insert', fertilizer_id, GETDATE() 
    FROM inserted;
END

CREATE TRIGGER updateFertilizer
ON Fertilizer
AFTER UPDATE
AS BEGIN
    INSERT INTO FertilizerAuditTrail (ActionType, fertilizer_id, TimeStamp)
    SELECT 'update', fertilizer_id, GETDATE() 
    FROM inserted;
END

CREATE TRIGGER deleteFertilizer
ON Fertilizer
AFTER DELETE
AS BEGIN
    INSERT INTO FertilizerAuditTrail (ActionType, fertilizer_id, TimeStamp)
    SELECT 'delete', fertilizer_id, GETDATE() 
    FROM deleted;
END

CREATE TABLE MachineryAuditTrail (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    ActionType VARCHAR(255),
    machinery_id INT,
    TimeStamp DATETIME
)

CREATE TRIGGER insertMachinery
ON Machinery
AFTER INSERT
AS BEGIN
    INSERT INTO MachineryAuditTrail (ActionType, machinery_id, TimeStamp)
    SELECT 'insert', machinery_id, GETDATE() 
    FROM inserted;
END

CREATE TRIGGER updateMachinery
ON Machinery
AFTER UPDATE
AS BEGIN
    INSERT INTO MachineryAuditTrail (ActionType, machinery_id, TimeStamp)
    SELECT 'update', machinery_id, GETDATE() 
    FROM inserted;
END

CREATE TRIGGER deleteMachinery
ON Machinery
AFTER DELETE
AS BEGIN
    INSERT INTO MachineryAuditTrail (ActionType, machinery_id, TimeStamp)
    SELECT 'delete', machinery_id, GETDATE() 
    FROM deleted;
END

--Procedures
CREATE PROCEDURE procInsertFarmer
    @Name VARCHAR(50),
    @Address VARCHAR(100),
    @Contact VARCHAR(20),
	@Password varchar(50)
AS
BEGIN
    INSERT INTO Farmer (farmer_name, farmer_address, farmer_contact, farmer_password)
    VALUES (@Name, @Address, @Contact, @Password);
END

CREATE PROCEDURE procUpdateFarmer
    @ID INT,
    @Name VARCHAR(50),
    @Address VARCHAR(100),
    @Contact VARCHAR(20),
	@Password varchar(50)
AS BEGIN
    UPDATE Farmer
    SET farmer_name = @Name, farmer_address = @Address, farmer_contact = @Contact, farmer_password = @Password
    WHERE farmer_id = @ID;
END

CREATE PROCEDURE procDeleteFarmer
    @ID INT
AS BEGIN
    DELETE FROM Farmer
    WHERE farmer_id = @ID;
END

CREATE PROCEDURE procInsertMachinery
    @Type VARCHAR(50),
    @Manufacturer VARCHAR(100),
    @Quantity INT
AS BEGIN
    INSERT INTO Machinery (machinery_type, machine_manufacturer, machinery_quantity)
    VALUES (@Type, @Manufacturer, @Quantity);
END

CREATE PROCEDURE procUpdateMachinery
    @ID INT,
    @Type VARCHAR(50),
    @Manufacturer VARCHAR(100),
    @Quantity INT
AS BEGIN
    UPDATE Machinery
    SET machinery_type = @Type, machine_manufacturer = @Manufacturer, machinery_quantity = @Quantity
    WHERE machinery_id = @ID;
END

CREATE PROCEDURE procDeleteMachinery
    @ID INT
AS BEGIN
    DELETE FROM Machinery
    WHERE machinery_id = @ID;
END

CREATE PROCEDURE procInsertTool
    @Name VARCHAR(50),
    @Manufacturer VARCHAR(100),
    @Quantity INT
AS BEGIN
    INSERT INTO Tool (tool_name, tool_manufacturer, tool_quantity)
    VALUES (@Name, @Manufacturer, @Quantity);
END

CREATE PROCEDURE procUpdateTool
    @ID INT,
    @Name VARCHAR(50),
    @Manufacturer VARCHAR(100),
    @Quantity INT
AS BEGIN
    UPDATE Tool
    SET tool_name = @Name, tool_manufacturer = @Manufacturer, tool_quantity = @Quantity
    WHERE tool_id = @ID;
END

CREATE PROCEDURE procDeleteTool
    @ID INT
AS BEGIN
    DELETE FROM Tool
    WHERE tool_id = @ID;
END

CREATE PROCEDURE procInsertFertilizer
    @Name VARCHAR(50),
    @Company VARCHAR(100),
    @Quality VARCHAR(20),
    @Quantity INT
AS BEGIN
    INSERT INTO Fertilizer (fertilizer_name, fertilizer_company, fertilizer_quality, fertilizer_quantity)
    VALUES (@Name, @Company, @Quality, @Quantity);
END

CREATE PROCEDURE procUpdateFertilizer
    @ID INT,
    @Name VARCHAR(50),
    @Company VARCHAR(100),
    @Quality VARCHAR(20),
    @Quantity INT
AS BEGIN
    UPDATE Fertilizer
    SET fertilizer_name = @Name, fertilizer_company = @Company, fertilizer_quality = @Quality, fertilizer_quantity = @Quantity
    WHERE fertilizer_id = @ID;
END

CREATE PROCEDURE procDeleteFertilizer
    @ID INT
AS BEGIN
    DELETE FROM Fertilizer
    WHERE fertilizer_id = @ID;
END

CREATE INDEX idx_loan_id ON Loan(loan_id)
CREATE INDEX idx_farmer_id ON Farmer(farmer_id)
