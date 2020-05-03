USE dial_metastore;
 

INSERT INTO QAR
           (Name
           ,BAO_UCORP_ID
           ,QAR_DAO
           ,Engineering_Lead)
     VALUES
		   ('Core Banking IDS', 1, 1, 'Andrei Zaichikov'),
		   ('Loan Department IDS', 1, 2, 'Andrei Zaichikov');
 

INSERT INTO GoldenSource
           (Name
           ,Description
           ,QarId)
     VALUES
           ('Core Banking ATM Transactions', 'Here we provide CDC data on the ATM transactions over the last few days', 1),
		   ('Loan Departments New Mortgages', 'We are appending all the data on new mortgage contracts and conditions', 2);
 

INSERT INTO BusinessLine
           (Name
           ,Description)
     VALUES
           ('Loan Department', 'Loans, Mortgages, etc.'),
		   ('ATM Department', 'Cash, ATM, etc.');
 

INSERT INTO DataDomain
           (Name
           ,Description)
     VALUES
           ('Analytical Data', 'Data for long-term analysis'),
		   ('Compliance Data', 'Data stored for compliancy reasons'),
		   ('Transactional Data', 'Ongoing transactions');
 

INSERT INTO ClassificationType
           (Name
           ,Description)
     VALUES
           ('PII', 'Personal Data'),
		   ('GDPR', 'Personal Data under GDPR compliance'),
		   ('Confidential', 'Highly-confidential data'),
		   ('Public', 'Publicly available data');
 

INSERT INTO DataTypeSource
           (Name
           ,Description
           ,DataTypeSourceVersion)
     VALUES
           ('Oracle', 'Exports from Oracle Database', '11g'),
		   ('SQL Server', 'Exports from SQL Server', '2005');
 

-- Asset Type
INSERT INTO Type
           (Name
           ,Description)
     VALUES
           ('File', ''),
		   ('Database Table', ''),
		   ('API', ''),
		   ('Stream', '');
 

INSERT INTO TransportType
           (Name
           ,Description)
     VALUES
           ('Direct File Transfer', ''),
           ('Azure Data Factory Copy', ''),
		   ('Shared Access Signature', 'Direct Access to ADLS');
 

-- Collation?
INSERT INTO Encoding
           (Name
           ,Description)
     VALUES
           ('UTF8', ''),
		   ('UTF16', '');
 

INSERT INTO Owner
           (Name
           ,Corp_ID)
     VALUES
           ('Andrei Zaichikov', 'anzaychi');
 

INSERT INTO Status
           (Name
           ,Description)
     VALUES
           ('Approved', ''),
		   ('Revoked', ''),
		   ('Rejected', '');
 

INSERT INTO Agreement
           (RequestorId
           ,QarId
           ,Description
           ,Purpose
           ,ExpirationDate)
     VALUES
           (1, 1, 'Access to the Core Banking Data for analysing and predicting cash flow', 'Analyzing and predicting Cash flow through ATMs', '20120618 10:34:09 AM'),
		   (1, 2, 'Access to the Loan data', 'Analyzing Mortgage Loans', '20200118 10:37:09 AM');
 

INSERT INTO AdditionalRestriction
           (Name
           ,Description)
     VALUES
           ('Geo-binding', 'Only employees of the certain geo can access this data');
 

INSERT INTO SystemInfo
           (QarId
           ,SystemName
           ,Description
           ,DisplayName
           ,AdditionalRestrictionsId
           ,GoldenSourceId
           ,Internal_External
           ,ProductOwner_Corp_Id)
     VALUES
           (1, 'ATM ML Pipeline', 'Predicts cash amount to be refilled', 'ABN_ATM_ML', 1, 1, 'Internal', 1),
		   (2, 'Mortgage Conditions Analysis', 'Implements set of R methods to analyze mortgage conditions', 'ABN_MOR_ANALYSIS', 1, 2, 'External', 1);
 

INSERT INTO Category
           (Name
           ,Description)
     VALUES
           ('Confidential', ''),
		   ('Public', ''),
		   ('Critical','');
 

INSERT INTO Dataset
           (GoldenSourceId
           ,Name
           ,Description
           ,QarId
           ,CategoryId
           ,DataDomainId
           ,BusinessLineId
           ,StatusId
           ,OwnerId
           ,DelegateOwnerId)
     VALUES
		   (1, 'ABN ATM Files Source', 'Files with ATM transcations (anonimized)', 1, 1, 3, 2, 1, 1, 1),
		   (1, 'ABN Mortgage Loan Files Source', 'Files with Mortgage Loan conditions (anonimized)', 2, 2, 1, 1, 3, 1, 1);
 

INSERT INTO Element
           (LogsId
           ,OrderSequence
           ,DataSetId
           ,Name
           ,Definition
           ,Critical
           ,PII
           ,NonSensitive
           ,ClassificationTypeId
           ,SurrogateId)
     VALUES
           (1, 100, 1, '20 count', 'Amount of 20 Euro notes ejected from the ATM', 'N', 'N', 'Y', 3, 0),
		   (1, 100, 1, '50 count', 'Amount of 50 Euro notes ejected from the ATM', 'N', 'N', 'Y', 3, 0),
		   (1, 100, 1, '10 count', 'Amount of 10 Euro notes ejected from the ATM', 'N', 'N', 'Y', 3, 0),
		   (1, 100, 1, '5 count', 'Amount of 5 Euro notes ejected from the ATM', 'N', 'N', 'Y', 3, 0),
		   (1, 100, 1, '100 count', 'Amount of 100 Euro notes ejected from the ATM', 'N', 'N', 'Y', 3, 0),
		   (1, 100, 1, 'ejection time', 'Time of cash ejection', 'N', 'N', 'Y', 3, 0),
		   (1, 100, 1, 'PAN', 'Bank card number', 'N', 'N', 'Y', 3, 0);
 

USE dial_metastore;
 

INSERT INTO AgreementElements
           (AgreementId
           ,ElementId
           ,LogsId
           ,Masked
           ,Approval
           ,Remark)
     VALUES
		   (1, 1, 1, 'N', 'Y', ''),
		   (1, 2, 1, 'N', 'Y', ''),
		   (1, 3, 1, 'N', 'Y', ''),
		   (1, 4, 1, 'N', 'Y', ''),
		   (1, 5, 1, 'N', 'Y', ''),
		   (1, 6, 1, 'N', 'Y', ''),
		   (1, 7, 1, 'Y', 'N', '');
 

INSERT INTO Interface
           (SystemId
           ,TypeId
           ,TransportTypeId
           ,Version
           ,Description
           ,StatusId
           ,Contact_Corp_Id)
     VALUES
		   (1, 1, 1, '0.1', '', 1, 1),
		   (1, 1, 2, '0.1', '', 1, 1);
 

INSERT INTO SourceFile
           (InterfaceId
           ,Filename
           ,Extention
           ,Delimiter
           ,FileFormat
           ,Header
           ,Footer
           ,Description
           ,TypeId
           ,TransportTypeId
           ,CompressionType
           ,DeliveryFrequency
           ,Push_Pull
           ,EncodingId)
     VALUES
		   (4, 'atm_20200201:12:30', 'csv', '¦', 'csv', 'Y', 'N', '', 1, 2, 'gzip', 'Once a day', 'Pull', 1);
 

INSERT INTO DataType
           (Name
           ,Description
           ,DataTypeSourceId)
     VALUES
		   ('int', '', 1),
		   ('int', '', 2),
		   ('time', '', 1);
 

INSERT INTO SourceAttribute
           (SourceField
           ,Order
           ,ColumnSequence
           ,DataTypeId
           ,FieldLength
           ,Unique
           ,Primary
           ,Nullable
           ,Index
           ,DefaultValue
           ,Precision
           ,Scale)
     VALUES
		   ('20', 'No order', 'No sequence', 2, '100', 'N', 'N', 'N', 'N', '', 10, 10),
		   ('10', 'No order', 'No sequence', 2, '100', 'N', 'N', 'N', 'N', '', 10, 10),
		   ('50', 'No order', 'No sequence', 2, '100', 'N', 'N', 'N', 'N', '', 10, 10),
		   ('100', 'No order', 'No sequence', 2, '100', 'N', 'N', 'N', 'N', '', 10, 10),
		   ('5', 'No order', 'No sequence', 2, '100', 'N', 'N', 'N', 'N', '', 10, 10),
		   ('time', 'No order', 'No sequence', 3, '100', 'N', 'N', 'N', 'N', '', 10, 10);
 

USE dial_metastore;
 

INSERT INTO ElementAttributes
           (SourceAttributeId
           ,ElementId)
     VALUES
           (1,1),
		   (2,3),
		   (3,2),
		   (4,5),
		   (5,4),
		   (6,6);
 
















