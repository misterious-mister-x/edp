/*3rd party metadata sources*/
-- DROP TABLE [QAR]
CREATE TABLE [QAR]
(
	[QARID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[BAO_UCORP_ID] [int] NOT NULL,
	[QAR_DAO] [int] NOT NULL,
	[Engineering_Lead] [nvarchar](255) NOT NULL,
	PRIMARY KEY (QARID)
)

/*Business Dictionary*/

-- DROP TABLE BusinessLine
CREATE TABLE [BusinessLine]
(
	[BusinessLineId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (BusinessLineId)
)

-- DROP TABLE [Category]
CREATE TABLE [Category]
(
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (CategoryId)
)

-- DROP TABLE [DataDomain]
CREATE TABLE [DataDomain]
(
	[DataDomainId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (DataDomainId)
)

/*Business Metadata*/

-- DROP TABLE [GoldenSource]
CREATE TABLE [GoldenSource]
(
	[GoldenSourceId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	[QarId] [int] NOT NULL,
	PRIMARY KEY (GoldenSourceId)
)

-- DROP Table [Owner]
CREATE TABLE [Owner]
(
	[OwnerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Corp_ID] [nvarchar](255) NOT NULL,
	PRIMARY KEY (OwnerId)
)

-- DROP TABLE [Status]
CREATE TABLE [Status]
(
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (StatusId)
)

-- DROP TABLE [DataSet]
CREATE TABLE [Dataset]
(
	[DatasetId] [int] IDENTITY(1,1) NOT NULL,
	[GoldenSourceId] [int],
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	[QarId] [int] NOT NULL, 
	[CategoryId] [int] NOT NULL, 
	[DataDomainId] [int] NOT NULL,
	[BusinessLineId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[OwnerId] [int] NOT NULL,
	[DelegateOwnerId] [int] NOT NULL,
	PRIMARY KEY (DataSetId),
	CONSTRAINT FK_DataSet_QAR FOREIGN KEY (QarId) REFERENCES QAR(QARID),
	CONSTRAINT FK_DataSet_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId),
	CONSTRAINT FK_DataSet_GoldenSource FOREIGN KEY (GoldenSourceId) REFERENCES GoldenSource(GoldenSourceId),
	CONSTRAINT FK_DataSet_DataDomain FOREIGN KEY (DataDomainId) REFERENCES DataDomain(DataDomainId),
	CONSTRAINT FK_DataSet_BusinessLine FOREIGN KEY (BusinessLineId) REFERENCES BusinessLine(BusinessLineId),
	CONSTRAINT FK_DataSet_Status FOREIGN KEY (StatusId) REFERENCES [Status](StatusId),
	CONSTRAINT FK_DataSet_Owner FOREIGN KEY (OwnerId) REFERENCES [Owner](OwnerId),
	CONSTRAINT FK_DataSet_DelegateOwner FOREIGN KEY (DelegateOwnerId) REFERENCES [Owner](OwnerId)
)
 
/*TODO*/
-- DROP TABLE [Element]
CREATE TABLE [Element]
(
	[ElementId] [int] IDENTITY(1,1) NOT NULL,
	[LogsId] [int] NOT NULL, -- what is this field for?
	[OrderSequence] [int] NOT NULL, -- is it a reference to somewhere
	[DataSetId] [int] NOT NULL, -- added in comparison with initial model
	[Name] [nvarchar](255) NOT NULL,
	[Definition] [ntext] NOT NULL,
	[Critical] [char](1) NOT NULL, 
	[PII] [char](1) NOT NULL, 
	[NonSensitive] [char](1) NOT NULL,
	[ClassificationTypeId] [int] NOT NULL,
	[SurrogateId] [int] NOT NULL, -- what is this field for?
	PRIMARY KEY (ElementId),
	CONSTRAINT FK_Element_DataSet FOREIGN KEY (DataSetId) REFERENCES DataSet(DataSetId),
	CONSTRAINT FK_Element_ClassificationType FOREIGN KEY (ClassificationTypeId) REFERENCES ClassificationType(ClassificationTypeId)
)

-- DROP TABLE [Agreement]
-- Agreement 2 Elements via Relations Table - modified from the initial model
CREATE TABLE [Agreement]
(
	[AgreementId] [int] IDENTITY(1,1) NOT NULL,
	[RequestorId] [int] NOT NULL,
	[QarId] [int] NOT NULL,
	[Description] [ntext] NOT NULL,
	[Purpose] [ntext] NOT NULL,
	[ExpirationDate] datetime NOT NULL, 
	PRIMARY KEY (AgreementId),
	CONSTRAINT FK_Agreement_QAR FOREIGN KEY (QarId) REFERENCES QAR(QARID),
	CONSTRAINT FK_Agreement_Requestor FOREIGN KEY (RequestorId) REFERENCES [Owner](OwnerId)
)

-- DROP TABLE [AgreementElements]
CREATE TABLE [AgreementElements]
(
	[AgreementElementsId] [int] IDENTITY(1,1) NOT NULL,
	[AgreementId] [int] NOT NULL,
	[ElementId] [int] NOT NULL, 
	[LogsId] [int] NOT NULL,
	[Masked] [char](1) NOT NULL,
	[Approval] [char](1) NOT NULL,
	[Remark] [ntext] NOT NULL,
	PRIMARY KEY (AgreementElementsId),
	CONSTRAINT FK_AgreementElements_Agreement FOREIGN KEY (AgreementId) REFERENCES Agreement(AgreementId),
	CONSTRAINT FK_AgreementElements_Element FOREIGN KEY (ElementId) REFERENCES [Element](ElementId)
)

/*Technical Dictionaries*/

-- DROP TABLE [Encoding]
CREATE TABLE [Encoding]
(
	[EncodingId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (EncodingId)
)

-- DROP TABLE [TransportType]
CREATE TABLE [TransportType]
(
	[TransportTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (TransportTypeId)
)

-- DROP TABLE [ClassificationType]
CREATE TABLE [ClassificationType]
(
	[ClassificationTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (ClassificationTypeId)
)

-- DROP TABLE AssetType
--CREATE TABLE [AssetType]
--(
--	[AssetTypeId] [int] IDENTITY(1,1) NOT NULL,
--	[Name] [nvarchar](255) NOT NULL,
--	[Description] [ntext] NOT NULL,
--	PRIMARY KEY (AssetTypeId)
--)

-- DROP TABLE DataType
CREATE TABLE [DataType]
(
	[DataTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	[DataTypeSourceId] [int] NOT NULL,
	PRIMARY KEY (DataTypeId)
)

-- DROP TABLE DataTypeSource
CREATE TABLE [DataTypeSource]
(
	[DataTypeSourceId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	[DataTypeSourceVersion] [nvarchar](255) NOT NULL,
	PRIMARY KEY (DataTypeSourceId),
	CONSTRAINT FK_DataType_DataTypeSource FOREIGN KEY (DataTypeSourceId) REFERENCES DataTypeSource(DataTypeSourceId)
) 

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
CREATE TABLE [AdditionalRestriction]
(
	[AdditionalRestrictionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (AdditionalRestrictionId)
)

-- DROP TABLE [Type]
CREATE TABLE [Type]
(
	[TypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	PRIMARY KEY (TypeId)
)

/*Technical Data*/
-- DROP TABLE [SystemInfo]
CREATE TABLE [SystemInfo]
(
	[SystemInfoId] [int] IDENTITY(1,1) NOT NULL,
	[QarId] [int] NOT NULL,
	[SystemName] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	[DisplayName] [nvarchar](255) NOT NULL,
	[AdditionalRestrictionsId] [int] NULL, -- chenged it into relation to dictionary
	[GoldenSourceId] [int] NOT NULL,
	[Internal_External] [nvarchar](20) NOT NULL, 
	[ProductOwner_Corp_Id] [int] NOT NULL,
	PRIMARY KEY (SystemInfoId),
	CONSTRAINT FK_SystemInfo_QAR FOREIGN KEY (QarId) REFERENCES QAR(QARID),
	CONSTRAINT FK_SystemInfo_AdditionalRestrictions FOREIGN KEY (AdditionalRestrictionsId) REFERENCES AdditionalRestriction(AdditionalRestrictionId),
	CONSTRAINT FK_SystemInfo_GoldenSource FOREIGN KEY (GoldenSourceId) REFERENCES GoldenSource(GoldenSourceId),
	CONSTRAINT FK_SystemInfo_ProductOwner FOREIGN KEY (ProductOwner_Corp_Id) REFERENCES [Owner](OwnerId)
)

-- DROP TABLE [Interface]
CREATE TABLE [Interface]
(
	[InterfaceId] [int] IDENTITY(1,1) NOT NULL,
	[SystemId] [int] NOT NULL,
	[TypeId] [int] NOT NULL, -- additional dictionary added
	[TransportTypeId] [int] NOT NULL,
	[Version] [nvarchar](255) NOT NULL,
	[Description] [ntext] NOT NULL,
	[StatusId] [int] NULL, -- chenged it into relation to dictionary
	[Contact_Corp_Id] [int] NOT NULL,
	PRIMARY KEY (InterfaceId),
	CONSTRAINT FK_Interface_System FOREIGN KEY (SystemId) REFERENCES SystemInfo(SystemInfoId),
	CONSTRAINT FK_Interface_Type FOREIGN KEY (TypeId) REFERENCES [Type](TypeId),
	CONSTRAINT FK_Interface_Status FOREIGN KEY (StatusId) REFERENCES [Status](StatusId),
	CONSTRAINT FK_Interface_TransportType FOREIGN KEY (TransportTypeId) REFERENCES TransportType(TransportTypeId),
	CONSTRAINT FK_Interface_ContactCorpId FOREIGN KEY (Contact_Corp_Id) REFERENCES [Owner](OwnerId)
)

-- DROP TABLE [SourceFile]
CREATE TABLE [SourceFile]
(
	[SourceFileId] [int] IDENTITY(1,1) NOT NULL,
	[InterfaceId] [int] NOT NULL,
	[Filename] [nvarchar](255) NOT NULL,
	[Extention] [nvarchar](255) NOT NULL,
	[Delimiter] [char](5) NOT NULL,
	[FileFormat] [nvarchar](25) NOT NULL,
	[Header] [char](5) NOT NULL,
	[Footer] [char](5) NOT NULL,
	[Description] [ntext] NOT NULL,
	[TypeId] [int] NOT NULL, -- additional dictionary added
	[TransportTypeId] [int] NOT NULL,
	[CompressionType] [nvarchar](25) NOT NULL,
	[DeliveryFrequency] [nvarchar](25) NOT NULL,
	[Push_Pull] [char](5) NOT NULL,
	[EncodingId] [int] NOT NULL,
	PRIMARY KEY (InterfaceId),
	CONSTRAINT FK_SourceFile_System FOREIGN KEY (InterfaceId) REFERENCES Interface(InterfaceId),
	CONSTRAINT FK_SourceFile_Type FOREIGN KEY (TypeId) REFERENCES [Type](TypeId),
	CONSTRAINT FK_SourceFile_TransportType FOREIGN KEY (TransportTypeId) REFERENCES TransportType(TransportTypeId),
	CONSTRAINT FK_SourceFile_Encoding FOREIGN KEY (EncodingId) REFERENCES [Encoding](EncodingId)
)

-- DROP TABLE [SourceAttribute]
CREATE TABLE [SourceAttribute]
(
	[SourceAttributeId] [int] IDENTITY(1,1) NOT NULL,
	[SourceField] [nvarchar](255) NOT NULL,
	[Order] [nvarchar](255) NOT NULL,
	[ColumnSequence] [nvarchar](255) NOT NULL,
	[DataTypeId] [int] NOT NULL,
	[FieldLength] [nvarchar](255) NOT NULL,
	[Unique] [char](1) NOT NULL,
	[Primary] [char](1) NOT NULL,
	[Nullable] [char](1) NOT NULL,
	[Index] [char](1) NOT NULL,
	[DefaultValue] [nvarchar](255) NOT NULL,
	[Precision] [int] NOT NULL, 
	[Scale] [int] NOT NULL,
	PRIMARY KEY (SourceAttributeId),
	CONSTRAINT FK_SourceAttribute_DataType FOREIGN KEY (DataTypeId) REFERENCES DataType(DataTypeId)
)
------ !!!!!!


-- DROP TABLE [AgreementElements]
-- access / delivery ?
CREATE TABLE [ElementAttributes]
(
	[ElementAttributesId] [int] IDENTITY(1,1) NOT NULL,
	[SourceAttributeId] [int] NOT NULL,
	[ElementId] [int] NOT NULL, 
	PRIMARY KEY (ElementAttributesId),
	CONSTRAINT FK_ElementAttributes_Attributes FOREIGN KEY (SourceAttributeId) REFERENCES SourceAttribute(SourceAttributeId),
	CONSTRAINT FK_ElementAttributes_Element FOREIGN KEY (ElementId) REFERENCES [Element](ElementId)
)