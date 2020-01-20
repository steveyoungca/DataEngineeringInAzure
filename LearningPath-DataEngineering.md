#Learning Path Data Engineering in Azure

As technology professionals, we are working during some of the most challenging times.  Not only is the pace of change increasing, but keeping up with the volume of new cloud-based products and services is becoming more difficult.  To survive in this environment, we must employ various learning techniques, and this **Learning Path** is an example of **Guided Technical Enablement**.  It provides a structure for quality curated content that a student can use to start  mastering a topic.

This learning Path covers **Azure Synapse Analytics** which Microsoft announced on November 4th 2019.  This service is not only the next evolution of Azure SQL Data Warehouse, but combines enterprise data warehousing and Big Data Analytics by providing serverless on-demand or provisioned resources at scale. Through the Azure Synapse Studio your team, made up of; Data Engineers, Data Scientists and IT Pros, can collaborate on projects to ingest, prepare, manage and serve data together in a single pane of glass experience.


![](https://5minutebi.com/wp-content/uploads/2019/12/01_synapsescreen2.png)

As this is a new offering, this learning path will be updated as more material is available; however, the content provided here will help to bring you up to speed in this product set.

### Goals and Format of this Learning Path

In this Learning Path for the **Azure Synapse Analytics**, you will find various online resources in a structured learning format.  Each level contains the objectives delivered through articles, labs and tutorials. 

The paths split into different levels to provide a structure to the process.

| **Level** | **Topic** |
| --- | --- | --- |
| **000** | Prerequisites |
| **100** | Introduction  |
| **200** | Basic Concepts |
| **300** | Optimization and Deep Technical |
| **400** | Best Practices and Use Cases |
| **More** | Resources |

The concepts and skills that this Learning Path covers would be beneficial for the following roles:

* **Data Professionals** looking for an introduction to Azure Synapse Analytics
* **Solution Architects** who design overall solutions that include Azure Synapse Analytics in end-to-end solutions.
* **BI and Data Developers** to understand how to design and implement Azure Synapse Analytics data solutions.
* **Data Professionals and DevOps teams***, who implement and operate Azure Synapse Analytics.

***
## Level 000 - The Prerequisites
With the introduction of Azure Synapse Analytics, most of the material is introductory.  The architecture, however, is composed of various Azure Data Services, which would have their own set of documentation.  Azure Synapse is the updated version Azure SQL Data Warehouse and as such some documentation has been updated with most of the other documentation remaining unchanged.

The main component of Azure Synapse Analytics is Azure SQL Data Warehouse.  I produced a learning path, [Learning Path Azure SQL Data Warehouse](https://github.com/steveyoungca/LearningPlans/blob/master/LearningPathAzureSQLDW.md) and am currently updating with new material, however this learning path contains updated documentation.

**Objectives**
- Define Azure Synapse Analytics
- Review some of the other services that make up Azure Synapse Analytics

[Azure Synapse Analytics - Limitless analytics service with unmatched time to insight](https://azure.microsoft.com/en-us/services/synapse-analytics/) - Overview page on the Azure Portal.

[What is Azure Synapse Analytics (formerly SQL DW)?](https://docs.microsoft.com/en-us/azure/sql-data-warehouse/sql-data-warehouse-overview-what-is) - High-level introduction to the services.

***
## Level 100 - The Basics 

The following section provides the Level 100 introduction articles.

**Objectives**
 
- Review the Architecture of a typical installation
- Gain hands-on overview of the tools

The following videos are 10 to 15 minutes in length and provide an introduction to Azure Synapse Analytics.

**Video**: [Azure Synapse Analytics - Next-gen Azure SQL Data Warehouse](https://www.youtube.com/watch?v=tMYOi5E14eU) - Limitless analytics service with unmatched time to insight. This is an end-to-end experience of building and deploying rich analytics scenarios and how you can automatically generate predictive models.

### SQL Data Warehouse Content - Updated
[Azure Synapse Analytics (formerly SQL DW) architecture](https://docs.microsoft.com/en-us/azure/sql-data-warehouse/massively-parallel-processing-mpp-architecture) - SQL Analytics leverages a scale-out architecture to distribute computational processing of data across multiple nodes.  This article covers the architecture by covering; Azure Storage, Control Node, Compute Nodes, Data Movement Service, Distributions and other architectural elements.

[Hands On: Quickstart: Create and query an Azure SQL Data Warehouse in the Azure portal](https://docs.microsoft.com/en-us/azure/sql-data-warehouse/create-data-warehouse-portal?source=docs)

The following PDF contains a lab that walks you through the creation of an environment in Azure with an Azure SQL Databases and a SQL Data Warehouse.  SQL Data Warehouse is a foundation technology for Azure Synapse Analytics. [Hands-On-Lab-SQL-DW-AzureSetUp](Hands-On-Lab-SQL-DW-AzureSetUp.pdf)

***
## Level 200 - Deeper Concepts

This section contains material that helps implement and use the services that make up Azure Synapse.

 **Objectives**

- Explain data loading practices
- Use Azure Synapse with Azure Machine Learning
- Review security in this environment


[Data loading strategies for Azure SQL Data Warehouse(New Copy Command)](https://docs.microsoft.com/en-us/azure/sql-data-warehouse/design-elt-data-loading) - Traditional SMP data warehouses use an Extract, Transform, and Load (ETL) process for loading data. Azure SQL Data Warehouse is a massively parallel processing (MPP) architecture that takes advantage of the scalability and flexibility of compute and storage resources. Utilizing an Extract, Load, and Transform (ELT) process can take advantage of MPP and eliminate resources needed to transform the data before loading. While SQL Data Warehouse supports many loading methods including popular SQL Server options such as BCP and the SQL BulkCopy API, the fastest and most scalable way to load data is through PolyBase external tables and the [COPY statement](https://docs.microsoft.com/en-us/sql/t-sql/statements/copy-into-transact-sql?view=azure-sqldw-latest) (is currently in preview with Azure Analytics). 


***
## Level 300 - Optimization and Deep Technical

This section goes deeper into building solutions, scaling and performance topics.

**Objectives**

- Review SQL Server Data Tools and their integration with Azure Synapse
- Review Performance and the various tools

[New in Azure Synapse Analytics: CICD for SQL Analytics using SQL Server Data Tools](https://cloudblogs.microsoft.com/sqlserver/2019/11/07/new-in-azure-synapse-analytics-cicd-for-sql-analytics-using-sql-server-data-tools/) - This release includes support for SQL Server Data Tools with Visual Studio 2019 along with native platform integration with Azure DevOps providing built-in continuous integration and deployment (CI/CD) capabilities for enterprise-level deployments. This announcement also comes with support for the Schema Compare extension in Azure Data Studio for SQL Analytics.  You can now expect a frictionless development and deployment experience on any platform for your analytics solution.


***
## Level 400 - Best Practices / Lessons from the field / Use Cases  

This section reviews some best practices and other material that help in solution development and operation.

**Objectives**

- Review Enterprise BI in azure with Azure Synapse
- Review Azure Data Factory and process automation

[Enterprise BI in Azure with Azure Synapse Analytics](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/data/enterprise-bi-synapse) -This reference architecture implements an extract, load, and transform (ELT) pipeline that moves data from an on-premises SQL Server database into Azure Synapse and transforms the data for analysis.
A reference implementation for this architecture is available on [GitHub](https://github.com/mspnp/reference-architectures/tree/master/data/enterprise_bi_sqldw).  **This is a must-read article**


***
## More Resources 

[How can we improve Microsoft Azure SQL Data Warehouse ?](https://feedback.azure.com/forums/307516-sql-data-warehouse) - Do you have an idea or suggestion based on your experience with SQL Data Warehouse? We would love to hear it! Please take a few minutes to submit your idea or vote up an idea submitted by another SQL Data Warehouse customer. All of the feedback you share in these forums will be monitored and reviewed by the SQL Data Warehouse engineering team. By suggesting or voting for ideas here, you will also be one of the first to know when we begin work on your feature requests and when we release the feature.
***
## Labs & Online Training 

More information will be added when available..


## End Notes

<sup>1</sup> Learning styles - Wikipedia.org – [https://en.wikipedia.org/wiki/Learning\_styles Sept 28,2019](https://en.wikipedia.org/wiki/Learning_styles%20Sept%2028,2019)




Links to be sorted

##Azure Data Factory

[Azure Data Factory documentation](https://docs.microsoft.com/en-us/azure/data-factory/)

[Monitor Data Flows](https://docs.microsoft.com/en-us/azure/data-factory/concepts-data-flow-monitoring)

[Tutorial: Transform data using mapping data flows](https://docs.microsoft.com/en-us/azure/data-factory/tutorial-data-flow)

[Advanced Threat Protection for Azure SQL Database](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-threat-detection-overview)

[Advanced data security for Azure SQL Database](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security)

[Azure SQL Database and SQL Data Warehouse data discovery & classification](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-data-discovery-and-classification?tabs=azure-t-sql)

[SQL Vulnerability Assessment service helps you identify database vulnerabilities](https://docs.microsoft.com/en-us/azure/sql-database/sql-vulnerability-assessment)

[Security controls for Azure SQL Database](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-controls)

[SQL Database Audit Log Format](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-audit-log-format)


[Run a web application in multiple Azure regions for high availability](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/app-service-web-app/multi-region)

[Use auto-failover groups to enable transparent and coordinated failover of multiple databases](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-auto-failover-group?tabs=azure-powershell)

[Tutorial: Add an Azure SQL Database single database to a failover group](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-single-database-failover-group-tutorial?tabs=azure-portal)

[Alert and monitor data factories by using Azure Monitor](https://docs.microsoft.com/en-us/azure/data-factory/monitor-using-azure-monitor)

[Design to Survive Failures (Building Real-World Cloud Apps with Azure)](https://docs.microsoft.com/en-us/aspnet/aspnet/overview/developing-apps-with-windows-azure/building-real-world-cloud-apps-with-windows-azure/design-to-survive-failures)

[O365 - Set the password expiration policy for your organization](https://docs.microsoft.com/en-CA/Office365/Admin/manage/set-password-expiration-policy?WT.mc_id=365AdminCSH&view=o365-worldwide)

[O365 - Set up multi-factor authentication](https://docs.microsoft.com/en-us/office365/admin/security-and-compliance/set-up-multi-factor-authentication?view=o365-worldwide)

[Configure multi-factor authentication for SQL Server Management Studio and Azure AD](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-ssms-mfa-authentication-configure)

[Using Multi-factor AAD authentication with Azure SQL Database and Azure SQL Data Warehouse (SSMS support for MFA)](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-ssms-mfa-authentication)


