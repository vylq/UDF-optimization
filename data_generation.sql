-- Test data generator for 50,000 orders with average 3 items each

-- Cleanup existing data in correct order (respecting foreign keys)
DELETE FROM WorkItem;
DELETE FROM Works; 
DELETE FROM Organization;
DELETE FROM PrintTemplate;
DELETE FROM TemplateType;
DELETE FROM Employee;
DELETE FROM Analiz;
DELETE FROM WorkStatus;
DELETE FROM SelectType;

-- Reset identity seeds
DBCC CHECKIDENT ('WorkItem', RESEED, 0);
DBCC CHECKIDENT ('Works', RESEED, 0);
DBCC CHECKIDENT ('Organization', RESEED, 0);
DBCC CHECKIDENT ('PrintTemplate', RESEED, 0);
DBCC CHECKIDENT ('TemplateType', RESEED, 0);
DBCC CHECKIDENT ('Employee', RESEED, 0);
DBCC CHECKIDENT ('Analiz', RESEED, 0);
DBCC CHECKIDENT ('WorkStatus', RESEED, 0);
DBCC CHECKIDENT ('SelectType', RESEED, 0);

-- Generate WorkStatus (5 records)
INSERT INTO WorkStatus (StatusName) VALUES 
('New'), ('In Progress'), ('Completed'), ('Pending Review'), ('Cancelled');

-- Generate SelectType (4 records)  
INSERT INTO SelectType (SelectType) VALUES 
('Standard'), ('Priority'), ('Urgent'), ('Research');

-- Generate TemplateType (3 records)
INSERT INTO TemplateType (TemlateVal, Comment) VALUES 
('Standard Report', 'Default template'), ('Detailed Report', 'Extended analysis'), ('Summary Report', 'Brief overview');

-- Generate PrintTemplate (3 records)
INSERT INTO PrintTemplate (TemplateName, Ext, Comment, Id_TemplateType) VALUES
('Template 1', 'docx', 'Auto generated', 1),
('Template 2', 'docx', 'Auto generated', 2),
('Template 3', 'docx', 'Auto generated', 3);

-- Generate Organizations (20 records)
INSERT INTO Organization (ORG_NAME, TEMPLATE_FN, Id_PrintTemplate, Email, Fax) VALUES
('MedCenter Alpha', 'template_1.docx', 1, 'medcenteralpha@medical.com', '+1-555-1001'),
('Hospital Beta', 'template_2.docx', 2, 'hospitalbeta@medical.com', '+1-555-1002'),
('Clinic Gamma', 'template_3.docx', 3, 'clinicgamma@medical.com', '+1-555-1003'),
('Lab Delta', 'template_1.docx', 1, 'labdelta@medical.com', '+1-555-1004'),
('MedFacility Epsilon', 'template_2.docx', 2, 'medfacilityepsilon@medical.com', '+1-555-1005'),
('Health Center Zeta', 'template_3.docx', 3, 'healthcenterzeta@medical.com', '+1-555-1006'),
('Diagnostic Eta', 'template_1.docx', 1, 'diagnosticeta@medical.com', '+1-555-1007'),
('Medical Lab Theta', 'template_2.docx', 2, 'medicallabtheta@medical.com', '+1-555-1008'),
('Care Center Iota', 'template_3.docx', 3, 'carecenteriota@medical.com', '+1-555-1009'),
('Health Lab Kappa', 'template_1.docx', 1, 'healthlabkappa@medical.com', '+1-555-1010'),
('Medical Facility Lambda', 'template_2.docx', 2, 'medicalfacilitylambda@medical.com', '+1-555-1011'),
('Diagnostic Center Mu', 'template_3.docx', 3, 'diagnosticcentermu@medical.com', '+1-555-1012'),
('Health Services Nu', 'template_1.docx', 1, 'healthservicesnu@medical.com', '+1-555-1013'),
('Lab Services Xi', 'template_2.docx', 2, 'labservicesxi@medical.com', '+1-555-1014'),
('Medical Center Omicron', 'template_3.docx', 3, 'medicalcenteromicron@medical.com', '+1-555-1015'),
('Diagnostic Lab Pi', 'template_1.docx', 1, 'diagnosticlabpi@medical.com', '+1-555-1016'),
('Health Diagnostics Rho', 'template_2.docx', 2, 'healthdiagnosticsrho@medical.com', '+1-555-1017'),
('Medical Services Sigma', 'template_3.docx', 3, 'medicalservicessigma@medical.com', '+1-555-1018'),
('Care Lab Tau', 'template_1.docx', 1, 'carelabtau@medical.com', '+1-555-1019'),
('Health Center Upsilon', 'template_2.docx', 2, 'healthcenterupsilon@medical.com', '+1-555-1020');

-- Generate Employees (50 records)
WITH EmployeeData AS (
  SELECT fname, lname, login, patronymic, rn FROM (VALUES 
    ('John','Smith','john.smith','JohnA',1),('Jane','Johnson','jane.johnson','JaneB',2),('Mike','Williams','mike.williams','MikeC',3),
    ('Sarah','Brown','sarah.brown','SarahD',4),('David','Jones','david.jones','DavidE',5),('Lisa','Garcia','lisa.garcia','LisaF',6),
    ('Robert','Miller','robert.miller','RobertG',7),('Maria','Davis','maria.davis','MariaH',8),('James','Rodriguez','james.rodriguez','JamesI',9),
    ('Jennifer','Martinez','jennifer.martinez','JenniferJ',10),('Michael','Hernandez','michael.hernandez','MichaelK',11),('Linda','Lopez','linda.lopez','LindaL',12),
    ('William','Gonzalez','william.gonzalez','WilliamM',13),('Elizabeth','Wilson','elizabeth.wilson','ElizabethN',14),('Richard','Anderson','richard.anderson','RichardO',15),
    ('Patricia','Thomas','patricia.thomas','PatriciaP',16),('Charles','Taylor','charles.taylor','CharlesQ',17),('Barbara','Moore','barbara.moore','BarbaraR',18),
    ('Christopher','Jackson','christopher.jackson','ChristopherS',19),('Susan','Martin','susan.martin','SusanT',20),('Daniel','Lee','daniel.lee','DanielU',21),
    ('Karen','Perez','karen.perez','KarenV',22),('Paul','Thompson','paul.thompson','PaulW',23),('Nancy','White','nancy.white','NancyX',24),
    ('Mark','Harris','mark.harris','MarkY',25),('Betty','Sanchez','betty.sanchez','BettyZ',26),('Donald','Clark','donald.clark','DonaldA',27),
    ('Helen','Ramirez','helen.ramirez','HelenB',28),('Steven','Lewis','steven.lewis','StevenC',29),('Donna','Robinson','donna.robinson','DonnaD',30),
    ('Kenneth','Walker','kenneth.walker','KennethE',31),('Carol','Young','carol.young','CarolF',32),('Joshua','Allen','joshua.allen','JoshuaG',33),
    ('Ruth','King','ruth.king','RuthH',34),('Kevin','Wright','kevin.wright','KevinI',35),('Sharon','Scott','sharon.scott','SharonJ',36),
    ('Brian','Torres','brian.torres','BrianK',37),('Michelle','Nguyen','michelle.nguyen','MichelleL',38),('Ronald','Hill','ronald.hill','RonaldM',39),
    ('Laura','Flores','laura.flores','LauraN',40),('Anthony','Green','anthony.green','AnthonyO',41),('Kimberly','Adams','kimberly.adams','KimberlyP',42),
    ('Thomas','Nelson','thomas.nelson','ThomasQ',43),('Deborah','Baker','deborah.baker','DeborahR',44),('Jason','Hall','jason.hall','JasonS',45),
    ('Dorothy','Rivera','dorothy.rivera','DorothyT',46),('Matthew','Campbell','matthew.campbell','MatthewU',47),('Amy','Mitchell','amy.mitchell','AmyV',48),
    ('Gary','Carter','gary.carter','GaryW',49),('Angela','Roberts','angela.roberts','AngelaX',50)
  ) t(fname, lname, login, patronymic, rn)
)
INSERT INTO Employee (Login_Name, Name, Patronymic, Surname, Email, Post, CreateDate, Archived, IS_Role, Role)
SELECT login, fname, patronymic, lname, login + '@lab.com',
       CASE (rn-1) % 4 WHEN 0 THEN 'Lab Technician' WHEN 1 THEN 'Senior Analyst' WHEN 2 THEN 'Lab Manager' ELSE 'Researcher' END,
       DATEADD(day, -(rn * 7) % 365, GETDATE()), 0, 0, (rn-1) % 3 + 1
FROM EmployeeData;

-- Generate Analiz (100 records) - Split into multiple INSERTs for simplicity
INSERT INTO Analiz (IS_GROUP, MATERIAL_TYPE, CODE_NAME, FULL_NAME, Text_Norm, Price, NormText, UnNormText) VALUES
(0,1,'CODE_001','Blood Test','Normal range varies by age and gender',125.50,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,2,'CODE_002','Urine Analysis','Normal range varies by age and gender',85.25,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,3,'CODE_003','X-Ray','Normal range varies by age and gender',200.00,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,4,'CODE_004','MRI Scan','Normal range varies by age and gender',850.75,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,5,'CODE_005','CT Scan','Normal range varies by age and gender',650.30,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,1,'CODE_006','Ultrasound','Normal range varies by age and gender',320.80,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,2,'CODE_007','ECG','Normal range varies by age and gender',110.40,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,3,'CODE_008','Blood Sugar','Normal range varies by age and gender',45.60,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,4,'CODE_009','Cholesterol','Normal range varies by age and gender',65.90,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,5,'CODE_010','Liver Function','Normal range varies by age and gender',95.20,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,1,'CODE_011','Kidney Function','Normal range varies by age and gender',105.15,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,2,'CODE_012','Thyroid Test','Normal range varies by age and gender',155.35,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,3,'CODE_013','Vitamin D','Normal range varies by age and gender',75.85,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,4,'CODE_014','Iron Level','Normal range varies by age and gender',55.45,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,5,'CODE_015','Hemoglobin','Normal range varies by age and gender',40.70,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,1,'CODE_016','Platelet Count','Normal range varies by age and gender',60.95,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,2,'CODE_017','White Blood Cell','Normal range varies by age and gender',50.25,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,3,'CODE_018','Cardiac Enzyme','Normal range varies by age and gender',180.40,'Results within normal parameters','Results outside normal range - requires follow-up'),
(0,4,'CODE_019','Tumor Marker','Normal range varies by age and gender',220.60,'Results within normal parameters','Results outside normal range - requires follow-up'),
(1,5,'CODE_020','Allergy Test','Normal range varies by age and gender',145.80,'Results within normal parameters','Results outside normal range - requires follow-up');

-- Continue with more Analiz records (simplified for space)
WITH AnalysisNumbers AS (
  SELECT n FROM (SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) + 20 as n FROM sys.all_objects) t WHERE n <= 100
)
INSERT INTO Analiz (IS_GROUP, MATERIAL_TYPE, CODE_NAME, FULL_NAME, Text_Norm, Price, NormText, UnNormText)
SELECT 
  CASE WHEN n % 20 = 0 THEN 1 ELSE 0 END,
  (n - 1) % 5 + 1,
  'CODE_' + FORMAT(n, '000'),
  'Analysis Test ' + CAST(n AS VARCHAR),
  'Normal range varies by age and gender',
  50.00 + (n % 100) * 5.5,
  'Results within normal parameters',
  'Results outside normal range - requires follow-up'
FROM AnalysisNumbers;

-- Generate 50,000 Works (Orders)
WITH NumberRows AS (
  SELECT TOP 50000 ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as rn
  FROM sys.all_objects a1 
  CROSS JOIN sys.all_objects a2
),
PatientNames AS (
  SELECT rn,
    CASE (rn-1) % 20
      WHEN 0 THEN 'John Smith' WHEN 1 THEN 'Jane Johnson' WHEN 2 THEN 'Mike Williams' WHEN 3 THEN 'Sarah Brown' WHEN 4 THEN 'David Jones'
      WHEN 5 THEN 'Lisa Garcia' WHEN 6 THEN 'Robert Miller' WHEN 7 THEN 'Maria Davis' WHEN 8 THEN 'James Rodriguez' WHEN 9 THEN 'Jennifer Martinez'
      WHEN 10 THEN 'Michael Wilson' WHEN 11 THEN 'Linda Anderson' WHEN 12 THEN 'William Thomas' WHEN 13 THEN 'Elizabeth Taylor' WHEN 14 THEN 'Richard Moore'
      WHEN 15 THEN 'Patricia Jackson' WHEN 16 THEN 'Charles Martin' WHEN 17 THEN 'Barbara Lee' WHEN 18 THEN 'Christopher Perez' ELSE 'Susan Thompson'
    END as patient_name,
    (rn % 50) + 1 as emp_id,
    (rn % 20) + 1 as org_id,
    (rn % 5) + 1 as status_id,
    DATEADD(day, -(rn % 180), GETDATE()) as create_date
  FROM NumberRows
)
INSERT INTO Works (IS_Complit, CREATE_Date, Id_Employee, ID_ORGANIZATION, MaterialNumber, FIO, PHONE, EMAIL, Is_Del, StatusId, Price)
SELECT 
  CASE WHEN rn % 10 < 8 THEN 1 ELSE 0 END,
  create_date,
  emp_id,
  org_id,
  CAST(rn AS DECIMAL(8,2)),
  patient_name,
  '+1-555-' + FORMAT((rn % 10000), '0000'),
  LOWER(REPLACE(patient_name, ' ', '.')) + '@email.com',
  0,
  status_id,
  CAST(100.00 + (rn % 200) * 4.5 AS DECIMAL(8,2))
FROM PatientNames;

-- Generate WorkItems (average 3 per order)
WITH WorkOrders AS (
  SELECT Id_Work, Id_Employee, CREATE_Date
  FROM Works
),
ItemCounts AS (
  SELECT Id_Work, Id_Employee, CREATE_Date, item_num
  FROM WorkOrders
  CROSS JOIN (VALUES (1),(2),(3)) items(item_num)
  WHERE (Id_Work % 10) < 7 OR item_num <= 2  -- Ensures average ~3 items per work
)
INSERT INTO WorkItem (CREATE_DATE, Is_Complit, Id_Employee, ID_ANALIZ, Id_Work, Is_Print, Is_Select, Price, Id_SelectType, Close_Date)
SELECT 
  DATEADD(hour, (Id_Work + item_num) % 48, CREATE_Date),
  CASE WHEN (Id_Work + item_num) % 10 < 7 THEN 1 ELSE 0 END,
  Id_Employee,
  ((Id_Work + item_num) % 100) + 1,
  Id_Work,
  1,
  CASE WHEN (Id_Work + item_num) % 10 < 3 THEN 1 ELSE 0 END,
  CAST(25.00 + ((Id_Work + item_num) % 50) * 3.5 AS DECIMAL(8,2)),
  ((Id_Work + item_num) % 4) + 1,
  CASE WHEN (Id_Work + item_num) % 10 < 6 THEN DATEADD(day, ((Id_Work + item_num) % 7) + 1, CREATE_Date) ELSE NULL END
FROM ItemCounts;

-- Update Works completion status based on WorkItems
UPDATE w SET IS_Complit = CASE WHEN completed_items = total_items THEN 1 ELSE 0 END
FROM Works w
INNER JOIN (
  SELECT Id_Work, 
         COUNT(*) as total_items,
         SUM(CASE WHEN Is_Complit = 1 THEN 1 ELSE 0 END) as completed_items
  FROM WorkItem 
  GROUP BY Id_Work
) stats ON w.Id_Work = stats.Id_Work;
