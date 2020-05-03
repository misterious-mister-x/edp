
--Below just a couple of examples why we need this model
--First is to check whenever we do have all the Datasets and all the proper data assigned 
--We can understand if this is enough, we need some more data or something is just not relevant
--Second is an example of simple validation rule which we can run over the model


-- Select All Elements of the dataset with an onwer and additional parameters
SELECT        Dataset.Name AS Dataset, Element.Name AS Element, Element.Critical, Element.PII, Element.NonSensitive, Owner.Name AS Owner, Owner.Corp_ID, ClassificationType.Name AS Classification, QAR.QARID, QAR.Name AS QAR, 
                         GoldenSource.GoldenSourceId AS GSID, GoldenSource.Name AS GoldenSource, DataDomain.Name AS DataDomain, BusinessLine.Name AS BusinessLine, Category.Name AS Category, Status.Name AS Status
FROM            Dataset INNER JOIN
                         GoldenSource ON Dataset.GoldenSourceId = GoldenSource.GoldenSourceId INNER JOIN
                         QAR ON Dataset.QarId = QAR.QARID INNER JOIN
                         BusinessLine ON Dataset.BusinessLineId = BusinessLine.BusinessLineId INNER JOIN
                         DataDomain ON Dataset.DataDomainId = DataDomain.DataDomainId INNER JOIN
                         Category ON Dataset.CategoryId = Category.CategoryId INNER JOIN
                         Status ON Dataset.StatusId = Status.StatusId LEFT OUTER JOIN
                         Owner ON Dataset.OwnerId = Owner.OwnerId FULL OUTER JOIN
                         ClassificationType INNER JOIN
                         Element ON ClassificationType.ClassificationTypeId = Element.ClassificationTypeId ON Dataset.DatasetId = Element.DataSetId

GO

-- Check classification Violations
SELECT        Dataset.Name AS Dataset, Element.Name AS Element, Element.Critical, Element.PII, Element.NonSensitive, Owner.Name AS Owner, Owner.Corp_ID, ClassificationType.Name AS Classification, Category.Name AS Category, 
                         Status.Name AS Status
FROM            Dataset INNER JOIN
                         Category ON Dataset.CategoryId = Category.CategoryId INNER JOIN
                         Status ON Dataset.StatusId = Status.StatusId LEFT OUTER JOIN
                         Owner ON Dataset.OwnerId = Owner.OwnerId FULL OUTER JOIN
                         ClassificationType INNER JOIN
                         Element ON ClassificationType.ClassificationTypeId = Element.ClassificationTypeId ON Dataset.DatasetId = Element.DataSetId
WHERE Element.Critical = 'N' AND ClassificationType.Name = 'Confidential'
