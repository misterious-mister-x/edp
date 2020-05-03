/*3rd party metadata sources*/
-- DROP TABLE [QAR]
CREATE SEQUENCE QAR_seq;

CREATE TABLE QAR
(
	QARID int DEFAULT NEXTVAL ('QAR_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	BAO_UCORP_ID int NOT NULL,
	QAR_DAO int NOT NULL,
	Engineering_Lead Varchar(255) NOT NULL,
	PRIMARY KEY (QARID)
);

/*Business Dictionary*/

-- DROP TABLE BusinessLine
CREATE SEQUENCE BusinessLine_seq;

CREATE TABLE BusinessLine
(
	BusinessLineId int DEFAULT NEXTVAL ('BusinessLine_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (BusinessLineId)
);

-- DROP TABLE [Category]
CREATE SEQUENCE Category_seq;

CREATE TABLE Category
(
	CategoryId int DEFAULT NEXTVAL ('Category_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (CategoryId)
);

-- DROP TABLE [DataDomain]
CREATE SEQUENCE DataDomain_seq;

CREATE TABLE DataDomain
(
	DataDomainId int DEFAULT NEXTVAL ('DataDomain_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (DataDomainId)
);

/*Business Metadata*/

-- DROP TABLE [GoldenSource]
CREATE SEQUENCE GoldenSource_seq;

CREATE TABLE GoldenSource
(
	GoldenSourceId int DEFAULT NEXTVAL ('GoldenSource_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	QarId int NOT NULL,
	PRIMARY KEY (GoldenSourceId)
);

-- DROP Table [Owner]
CREATE SEQUENCE Owner_seq;

CREATE TABLE Owner
(
	OwnerId int DEFAULT NEXTVAL ('Owner_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Corp_ID Varchar(255) NOT NULL,
	PRIMARY KEY (OwnerId)
);

-- DROP TABLE [Status]
CREATE SEQUENCE Status_seq;

CREATE TABLE Status
(
	StatusId int DEFAULT NEXTVAL ('Status_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (StatusId)
);

-- DROP TABLE [DataSet]
CREATE SEQUENCE Dataset_seq;

CREATE TABLE Dataset
(
	DatasetId int DEFAULT NEXTVAL ('Dataset_seq') NOT NULL,
	GoldenSourceId int,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	QarId int NOT NULL, 
	CategoryId int NOT NULL, 
	DataDomainId int NOT NULL,
	BusinessLineId int NOT NULL,
	StatusId int NOT NULL,
	OwnerId int NOT NULL,
	DelegateOwnerId int NOT NULL,
	PRIMARY KEY (DataSetId),
	CONSTRAINT FK_DataSet_QAR FOREIGN KEY (QarId) REFERENCES QAR(QARID),
	CONSTRAINT FK_DataSet_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId),
	CONSTRAINT FK_DataSet_GoldenSource FOREIGN KEY (GoldenSourceId) REFERENCES GoldenSource(GoldenSourceId),
	CONSTRAINT FK_DataSet_DataDomain FOREIGN KEY (DataDomainId) REFERENCES DataDomain(DataDomainId),
	CONSTRAINT FK_DataSet_BusinessLine FOREIGN KEY (BusinessLineId) REFERENCES BusinessLine(BusinessLineId),
	CONSTRAINT FK_DataSet_Status FOREIGN KEY (StatusId) REFERENCES Status(StatusId),
	CONSTRAINT FK_DataSet_Owner FOREIGN KEY (OwnerId) REFERENCES Owner(OwnerId),
	CONSTRAINT FK_DataSet_DelegateOwner FOREIGN KEY (DelegateOwnerId) REFERENCES Owner(OwnerId)
);
 
/*TODO*/
-- DROP TABLE [Element]
CREATE SEQUENCE Element_seq;

CREATE TABLE Element
(
	ElementId int DEFAULT NEXTVAL ('Element_seq') NOT NULL,
	LogsId int NOT NULL, -- what is this field for?
	OrderSequence int NOT NULL, -- is it a reference to somewhere
	DataSetId int NOT NULL, -- added in comparison with initial model
	Name Varchar(255) NOT NULL,
	Definition Text NOT NULL,
	Critical char(1) NOT NULL, 
	PII char(1) NOT NULL, 
	NonSensitive char(1) NOT NULL,
	ClassificationTypeId int NOT NULL,
	SurrogateId int NOT NULL, -- what is this field for?
	PRIMARY KEY (ElementId),
	CONSTRAINT FK_Element_DataSet FOREIGN KEY (DataSetId) REFERENCES DataSet(DataSetId),
	CONSTRAINT FK_Element_ClassificationType FOREIGN KEY (ClassificationTypeId) REFERENCES ClassificationType(ClassificationTypeId)
);

-- DROP TABLE [Agreement]
-- Agreement 2 Elements via Relations Table - modified from the initial model
CREATE SEQUENCE Agreement_seq;

CREATE TABLE Agreement
(
	AgreementId int DEFAULT NEXTVAL ('Agreement_seq') NOT NULL,
	RequestorId int NOT NULL,
	QarId int NOT NULL,
	Description Text NOT NULL,
	Purpose Text NOT NULL,
	ExpirationDate timestamp(3) NOT NULL, 
	PRIMARY KEY (AgreementId),
	CONSTRAINT FK_Agreement_QAR FOREIGN KEY (QarId) REFERENCES QAR(QARID),
	CONSTRAINT FK_Agreement_Requestor FOREIGN KEY (RequestorId) REFERENCES Owner(OwnerId)
);

-- DROP TABLE [AgreementElements]
CREATE SEQUENCE AgreementElements_seq;

CREATE TABLE AgreementElements
(
	AgreementElementsId int DEFAULT NEXTVAL ('AgreementElements_seq') NOT NULL,
	AgreementId int NOT NULL,
	ElementId int NOT NULL, 
	LogsId int NOT NULL,
	Masked char(1) NOT NULL,
	Approval char(1) NOT NULL,
	Remark Text NOT NULL,
	PRIMARY KEY (AgreementElementsId),
	CONSTRAINT FK_AgreementElements_Agreement FOREIGN KEY (AgreementId) REFERENCES Agreement(AgreementId),
	CONSTRAINT FK_AgreementElements_Element FOREIGN KEY (ElementId) REFERENCES Element(ElementId)
);

/*Technical Dictionaries*/

-- DROP TABLE [Encoding]
CREATE SEQUENCE Encoding_seq;

CREATE TABLE Encoding
(
	EncodingId int DEFAULT NEXTVAL ('Encoding_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (EncodingId)
);

-- DROP TABLE [TransportType]
CREATE SEQUENCE TransportType_seq;

CREATE TABLE TransportType
(
	TransportTypeId int DEFAULT NEXTVAL ('TransportType_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (TransportTypeId)
);

-- DROP TABLE [ClassificationType]
CREATE SEQUENCE ClassificationType_seq;

CREATE TABLE ClassificationType
(
	ClassificationTypeId int DEFAULT NEXTVAL ('ClassificationType_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (ClassificationTypeId)
);

-- DROP TABLE AssetType
--CREATE TABLE [AssetType]
--(
--	[AssetTypeId] [int] IDENTITY(1,1) NOT NULL,
--	[Name] [nvarchar](255) NOT NULL,
--	[Description] [ntext] NOT NULL,
--	PRIMARY KEY (AssetTypeId)
--)

-- DROP TABLE DataType
CREATE SEQUENCE DataType_seq;

CREATE TABLE DataType
(
	DataTypeId int DEFAULT NEXTVAL ('DataType_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	DataTypeSourceId int NOT NULL,
	PRIMARY KEY (DataTypeId)
);

-- DROP TABLE DataTypeSource
CREATE SEQUENCE DataTypeSource_seq;

CREATE TABLE DataTypeSource
(
	DataTypeSourceId int DEFAULT NEXTVAL ('DataTypeSource_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	DataTypeSourceVersion Varchar(255) NOT NULL,
	PRIMARY KEY (DataTypeSourceId),
	CONSTRAINT FK_DataType_DataTypeSource FOREIGN KEY (DataTypeSourceId) REFERENCES DataTypeSource(DataTypeSourceId)
); 

-- DROP TABLE [DeliveryType]
--CREATE TABLE [DeliveryType]
--(
--	[DeliveryTypeId] [int] IDENTITY(1,1) NOT NULL,
--	[Name] [nvarchar](255) NOT NULL,
--	[Description] [ntext] NOT NULL,
--	[ScheduleId] [int] NULL,
--	PRIMARY KEY (DeliveryTypeId)
--)

-- DROP TABLE [AdditionalRestrictions]
CREATE SEQUENCE AdditionalRestriction_seq;

CREATE TABLE AdditionalRestriction
(
	AdditionalRestrictionId int DEFAULT NEXTVAL ('AdditionalRestriction_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (AdditionalRestrictionId)
);

-- DROP TABLE [Type]
CREATE SEQUENCE Type_seq;

CREATE TABLE Type
(
	TypeId int DEFAULT NEXTVAL ('Type_seq') NOT NULL,
	Name Varchar(255) NOT NULL,
	Description Text NOT NULL,
	PRIMARY KEY (TypeId)
);

/*Technical Data*/
-- DROP TABLE [SystemInfo]
CREATE SEQUENCE SystemInfo_seq;

CREATE TABLE SystemInfo
(
	SystemInfoId int DEFAULT NEXTVAL ('SystemInfo_seq') NOT NULL,
	QarId int NOT NULL,
	SystemName Varchar(255) NOT NULL,
	Description Text NOT NULL,
	DisplayName Varchar(255) NOT NULL,
	AdditionalRestrictionsId int NULL, -- chenged it into relation to dictionary
	GoldenSourceId int NOT NULL,
	Internal_External Varchar(20) NOT NULL, 
	ProductOwner_Corp_Id int NOT NULL,
	PRIMARY KEY (SystemInfoId),
	CONSTRAINT FK_SystemInfo_QAR FOREIGN KEY (QarId) REFERENCES QAR(QARID),
	CONSTRAINT FK_SystemInfo_AdditionalRestrictions FOREIGN KEY (AdditionalRestrictionsId) REFERENCES AdditionalRestriction(AdditionalRestrictionId),
	CONSTRAINT FK_SystemInfo_GoldenSource FOREIGN KEY (GoldenSourceId) REFERENCES GoldenSource(GoldenSourceId),
	CONSTRAINT FK_SystemInfo_ProductOwner FOREIGN KEY (ProductOwner_Corp_Id) REFERENCES Owner(OwnerId)
);

-- DROP TABLE [Interface]
CREATE SEQUENCE Interface_seq;

CREATE TABLE Interface
(
	InterfaceId int DEFAULT NEXTVAL ('Interface_seq') NOT NULL,
	SystemId int NOT NULL,
	TypeId int NOT NULL, -- additional dictionary added
	TransportTypeId int NOT NULL,
	Version Varchar(255) NOT NULL,
	Description Text NOT NULL,
	StatusId int NULL, -- chenged it into relation to dictionary
	Contact_Corp_Id int NOT NULL,
	PRIMARY KEY (InterfaceId),
	CONSTRAINT FK_Interface_System FOREIGN KEY (SystemId) REFERENCES SystemInfo(SystemInfoId),
	CONSTRAINT FK_Interface_Type FOREIGN KEY (TypeId) REFERENCES Type(TypeId),
	CONSTRAINT FK_Interface_Status FOREIGN KEY (StatusId) REFERENCES Status(StatusId),
	CONSTRAINT FK_Interface_TransportType FOREIGN KEY (TransportTypeId) REFERENCES TransportType(TransportTypeId),
	CONSTRAINT FK_Interface_ContactCorpId FOREIGN KEY (Contact_Corp_Id) REFERENCES Owner(OwnerId)
);

-- DROP TABLE [SourceFile]
CREATE SEQUENCE SourceFile_seq;

CREATE TABLE SourceFile
(
	SourceFileId int DEFAULT NEXTVAL ('SourceFile_seq') NOT NULL,
	InterfaceId int NOT NULL,
	Filename Varchar(255) NOT NULL,
	Extention Varchar(255) NOT NULL,
	Delimiter char(5) NOT NULL,
	FileFormat Varchar(25) NOT NULL,
	Header char(5) NOT NULL,
	Footer char(5) NOT NULL,
	Description Text NOT NULL,
	TypeId int NOT NULL, -- additional dictionary added
	TransportTypeId int NOT NULL,
	CompressionType Varchar(25) NOT NULL,
	DeliveryFrequency Varchar(25) NOT NULL,
	Push_Pull char(5) NOT NULL,
	EncodingId int NOT NULL,
	PRIMARY KEY (InterfaceId),
	CONSTRAINT FK_SourceFile_System FOREIGN KEY (InterfaceId) REFERENCES Interface(InterfaceId),
	CONSTRAINT FK_SourceFile_Type FOREIGN KEY (TypeId) REFERENCES Type(TypeId),
	CONSTRAINT FK_SourceFile_TransportType FOREIGN KEY (TransportTypeId) REFERENCES TransportType(TransportTypeId),
	CONSTRAINT FK_SourceFile_Encoding FOREIGN KEY (EncodingId) REFERENCES Encoding(EncodingId)
);

-- DROP TABLE [SourceAttribute]
CREATE SEQUENCE SourceAttribute_seq;

CREATE TABLE SourceAttribute
(
	SourceAttributeId int DEFAULT NEXTVAL ('SourceAttribute_seq') NOT NULL,
	SourceField Varchar(255) NOT NULL,
	Order Varchar(255) NOT NULL,
	ColumnSequence Varchar(255) NOT NULL,
	DataTypeId int NOT NULL,
	FieldLength Varchar(255) NOT NULL,
	Unique char(1) NOT NULL,
	Primary char(1) NOT NULL,
	Nullable char(1) NOT NULL,
	Index char(1) NOT NULL,
	DefaultValue Varchar(255) NOT NULL,
	Precision int NOT NULL, 
	Scale int NOT NULL,
	PRIMARY KEY (SourceAttributeId),
	CONSTRAINT FK_SourceAttribute_DataType FOREIGN KEY (DataTypeId) REFERENCES DataType(DataTypeId)
);
------ !!!!!!


-- DROP TABLE [AgreementElements]
-- access / delivery ?
CREATE SEQUENCE ElementAttributes_seq;

CREATE TABLE ElementAttributes
(
	ElementAttributesId int DEFAULT NEXTVAL ('ElementAttributes_seq') NOT NULL,
	SourceAttributeId int NOT NULL,
	ElementId int NOT NULL, 
	PRIMARY KEY (ElementAttributesId),
	CONSTRAINT FK_ElementAttributes_Attributes FOREIGN KEY (SourceAttributeId) REFERENCES SourceAttribute(SourceAttributeId),
	CONSTRAINT FK_ElementAttributes_Element FOREIGN KEY (ElementId) REFERENCES Element(ElementId)
);
