use importScenarioDb

/****** Object:  Table [dbo].[omc_Contacts]    Script Date: 5/7/2020 10:04:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_Contacts](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[TimeZoneId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[OrganizationId] [int] NULL,
	[FirstName] [nvarchar](255) NULL,
	[SurName] [nvarchar](255) NULL,
	[Gender] [int] NULL,
	[BirthDate] [date] NULL,
	[Age] [int] NULL,
	[CountryId] [int] NOT NULL,
	[Salutation] [nvarchar](50) NULL,
	[FirstNameVocative] [nvarchar](255) NULL,
	[SurNameVocative] [nvarchar](255) NULL,
	[MetaRecordOrigin] [nvarchar](50) NULL,
	[CallCenterAgentId] [int] NULL,
	[RelatedSystemUserId] [int] NULL,
	[CompanyId] [int] NULL,
	[MetaInfo] [nvarchar](max) NULL,
	[OrganizationText] [nvarchar](100) NULL,
	[Title] [nvarchar](50) NULL,
	[ShortText1] [nvarchar](100) NULL,
	[ShortText2] [nvarchar](100) NULL,
	[Text1] [nvarchar](255) NULL,
	[Text2] [nvarchar](255) NULL,
	[MasterSystemAbsoluteURL] [nvarchar](500) NULL,
	[CurrencyId] [int] NOT NULL,
	[DateFormatId] [int] NOT NULL,
	[ParentContactId] [int] NULL,
	[ExternalId] [nvarchar](100) NULL,
	[LockImport] [bit] NULL,
 CONSTRAINT [omc_PK_Contacts] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_Contacts] ADD  CONSTRAINT [DF_omc_Contacts_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_Contacts] ADD  CONSTRAINT [DF_omc_Contacts_TimeZoneId]  DEFAULT ((1)) FOR [TimeZoneId]
GO

ALTER TABLE [dbo].[omc_Contacts] ADD  CONSTRAINT [DF_omc_Contacts_LanguageId]  DEFAULT ((1)) FOR [LanguageId]
GO

/****** Object:  Table [dbo].[omc_ContactEmails]    Script Date: 5/7/2020 10:13:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_ContactEmails](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[MetaData] [ntext] NULL,
	[UseThis] [bit] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_omc_ContactEmails_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_ContactEmails] ADD  CONSTRAINT [DF_omc_ContactEmails_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_ContactEmails]  WITH CHECK ADD  CONSTRAINT [FK_omc_ContactEmails_omc_ContactEmails] FOREIGN KEY([ContactId])
REFERENCES [dbo].[omc_Contacts] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_ContactEmails] CHECK CONSTRAINT [FK_omc_ContactEmails_omc_ContactEmails]
GO


/****** Object:  Table [dbo].[omc_ContactMobiles]    Script Date: 5/7/2020 10:14:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_ContactMobiles](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[MobileNumber] [nvarchar](255) NOT NULL,
	[MetaData] [ntext] NULL,
	[UseThis] [bit] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_omc_ContactMobiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_ContactMobiles] ADD  CONSTRAINT [DF_omc_ContactMobiles_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_ContactMobiles]  WITH CHECK ADD  CONSTRAINT [FK_omc_ContactMobiles_omc_Contacts] FOREIGN KEY([ContactId])
REFERENCES [dbo].[omc_Contacts] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_ContactMobiles] CHECK CONSTRAINT [FK_omc_ContactMobiles_omc_Contacts]
GO

/****** Object:  Table [dbo].[omc_ContactTelephones]    Script Date: 5/7/2020 10:15:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_ContactTelephones](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[TelephoneNumber] [nvarchar](255) NOT NULL,
	[UseThis] [bit] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_omc_ContactTelephones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_ContactTelephones] ADD  CONSTRAINT [DF_omc_ContactTelephones_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_ContactTelephones]  WITH CHECK ADD  CONSTRAINT [FK_omc_ContactTelephones_omc_Contacts] FOREIGN KEY([ContactId])
REFERENCES [dbo].[omc_Contacts] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_ContactTelephones] CHECK CONSTRAINT [FK_omc_ContactTelephones_omc_Contacts]
GO

/****** Object:  Table [dbo].[omc_ContactPostalAddresses]    Script Date: 5/7/2020 10:16:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_ContactPostalAddresses](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressDescription] [nvarchar](50) NULL,
	[AddressLine1] [nvarchar](300) NULL,
	[AddressLine2] [nvarchar](300) NULL,
	[ZipCode] [varchar](20) NULL,
	[City] [nvarchar](100) NULL,
	[CountryId] [int] NULL,
	[ContactId] [int] NOT NULL,
	[UseThis] [bit] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[PoBox] [nvarchar](10) NULL,
	[Lat] [varchar](20) NULL,
	[Lng] [varchar](20) NULL,
	[Location]  AS ([geography]::STGeomFromText(((('POINT('+[Lng])+' ')+[Lat])+')',(4326))) PERSISTED,
 CONSTRAINT [PK_omc_ContactPostalAddresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].[omc_ContactPostalAddresses] ADD  CONSTRAINT [DF_omc_ContactPostalAddresses_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_ContactPostalAddresses]  WITH CHECK ADD  CONSTRAINT [FK_omc_ContactPostalAddresses_omc_Contacts] FOREIGN KEY([ContactId])
REFERENCES [dbo].[omc_Contacts] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_ContactPostalAddresses] CHECK CONSTRAINT [FK_omc_ContactPostalAddresses_omc_Contacts]
GO

/****** Object:  Table [dbo].[omc_SubscriptionSchemes]    Script Date: 5/7/2020 10:18:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_SubscriptionSchemes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[IsVisibleToUser] [bit] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[TenantId] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_omc_SubscriptionSchemes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_SubscriptionSchemes] ADD  CONSTRAINT [DF_omc_SubscriptionSchemes_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

/****** Object:  Table [dbo].[omc_SubscriptionSchemeExplicitOptInOuts]    Script Date: 5/7/2020 10:18:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_SubscriptionSchemeExplicitOptInOuts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[ContactId] [int] NOT NULL,
	[SubscriptionSchemeId] [int] NOT NULL,
	[ChannelType] [int] NOT NULL,
	[OptInOut] [int] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[TenantId] [int] NOT NULL,
	[ModifiedDateUtc] [datetime] NOT NULL,
 CONSTRAINT [PK_omc_SubscriptionSchemeExplicitOptInOuts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_SubscriptionSchemeExplicitOptInOuts] ADD  CONSTRAINT [DF_omc_SubscriptionSchemeExplicitOptInOuts_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_SubscriptionSchemeExplicitOptInOuts] ADD  DEFAULT (getdate()) FOR [ModifiedDateUtc]
GO

ALTER TABLE [dbo].[omc_SubscriptionSchemeExplicitOptInOuts]  WITH CHECK ADD  CONSTRAINT [FK_omc_SubscriptionSchemeExplicitOptInOuts_omc_Contacts] FOREIGN KEY([ContactId])
REFERENCES [dbo].[omc_Contacts] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_SubscriptionSchemeExplicitOptInOuts] CHECK CONSTRAINT [FK_omc_SubscriptionSchemeExplicitOptInOuts_omc_Contacts]
GO

ALTER TABLE [dbo].[omc_SubscriptionSchemeExplicitOptInOuts]  WITH CHECK ADD  CONSTRAINT [FK_omc_SubscriptionSchemeExplicitOptInOuts_omc_SubscriptionSchemes] FOREIGN KEY([SubscriptionSchemeId])
REFERENCES [dbo].[omc_SubscriptionSchemes] ([Id])
GO

ALTER TABLE [dbo].[omc_SubscriptionSchemeExplicitOptInOuts] CHECK CONSTRAINT [FK_omc_SubscriptionSchemeExplicitOptInOuts_omc_SubscriptionSchemes]
GO

/****** Object:  Table [dbo].[omc_CoreEntities]    Script Date: 5/7/2020 10:20:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_CoreEntities](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[EntityType] [int] NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[RootContactItem] [bit] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_omc_CoreEntities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_CoreEntities] ADD  CONSTRAINT [DF_omc_CoreEntities_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

/****** Object:  Table [dbo].[omc_CoreEntityColumns]    Script Date: 5/7/2020 10:21:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_CoreEntityColumns](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CoreEntityId] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[ColumnName] [nvarchar](250) NOT NULL,
	[Size] [int] NOT NULL,
	[DataType] [int] NOT NULL,
	[IsNullable] [bit] NOT NULL,
	[UseInEasyQuery] [bit] NOT NULL,
	[UseInCKEditor] [bit] NOT NULL,
	[UseInConditions] [bit] NOT NULL,
	[UseInResult] [bit] NOT NULL,
	[UseInSorting] [bit] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_omc_CoreEntityColumns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_CoreEntityColumns] ADD  CONSTRAINT [DF_omc_CoreEntityColumns_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_CoreEntityColumns]  WITH CHECK ADD  CONSTRAINT [FK_omc_CoreEntityColumns_omc_CoreEntities] FOREIGN KEY([CoreEntityId])
REFERENCES [dbo].[omc_CoreEntities] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_CoreEntityColumns] CHECK CONSTRAINT [FK_omc_CoreEntityColumns_omc_CoreEntities]
GO

/****** Object:  Table [dbo].[omc_CoreEntityLocalizations]    Script Date: 5/7/2020 10:21:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_CoreEntityLocalizations](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[CoreEntityId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_omc_CoreEntityLocalizations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_CoreEntityLocalizations] ADD  CONSTRAINT [DF_omc_CoreEntityLocalizations_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_CoreEntityLocalizations]  WITH CHECK ADD  CONSTRAINT [FK_omc_CoreEntityLocalizations_omc_CoreEntities] FOREIGN KEY([CoreEntityId])
REFERENCES [dbo].[omc_CoreEntities] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_CoreEntityLocalizations] CHECK CONSTRAINT [FK_omc_CoreEntityLocalizations_omc_CoreEntities]
GO

/****** Object:  Table [dbo].[omc_CoreEntityColumnLocalizations]    Script Date: 5/7/2020 10:22:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_CoreEntityColumnLocalizations](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[CoreEntityColumnId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_omc_CoreEntityColumnLocalizations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_CoreEntityColumnLocalizations] ADD  CONSTRAINT [DF_omc_CoreEntityColumnLocalizations_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_CoreEntityColumnLocalizations]  WITH CHECK ADD  CONSTRAINT [FK_omc_CoreEntityColumnLocalizations_omc_CoreEntityColumns] FOREIGN KEY([CoreEntityColumnId])
REFERENCES [dbo].[omc_CoreEntityColumns] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_CoreEntityColumnLocalizations] CHECK CONSTRAINT [FK_omc_CoreEntityColumnLocalizations_omc_CoreEntityColumns]
GO

/****** Object:  Table [dbo].[omc_ContactItems]    Script Date: 5/7/2020 10:23:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[omc_ContactItems](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CoreEntityId] [int] NOT NULL,
	[ContactId] [int] NOT NULL,
	[Description] [nvarchar](150) NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[ExternalId] [nvarchar](100) NULL,
	[LockImport] [bit] NULL,
 CONSTRAINT [PK_omc_ContactItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[omc_ContactItems] ADD  CONSTRAINT [DF_omc_ContactItems_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[omc_ContactItems]  WITH CHECK ADD  CONSTRAINT [FK_omc_ContactItems_omc_Contacts] FOREIGN KEY([ContactId])
REFERENCES [dbo].[omc_Contacts] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[omc_ContactItems] CHECK CONSTRAINT [FK_omc_ContactItems_omc_Contacts]
GO

ALTER TABLE [dbo].[omc_ContactItems]  WITH CHECK ADD  CONSTRAINT [FK_omc_ContactItems_omc_CoreEntities] FOREIGN KEY([CoreEntityId])
REFERENCES [dbo].[omc_CoreEntities] ([Id])
GO

ALTER TABLE [dbo].[omc_ContactItems] CHECK CONSTRAINT [FK_omc_ContactItems_omc_CoreEntities]
GO

/****** Object:  Table [dbo].[sys_Languages]    Script Date: 5/8/2020 7:58:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sys_Languages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TwoLetterCode] [char](2) NOT NULL,
	[ThreeLetterCode] [char](3) NULL,
	[Name] [varchar](100) NOT NULL,
	[NameEL] [nvarchar](100) NULL,
	[NameEN] [nvarchar](100) NULL,
	[Culture] [varchar](20) NULL,
	[IsoEncoding] [varchar](20) NULL,
	[TenantId] [int] NOT NULL,
	[RowVersion] [timestamp] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[IsDefault] [bit] NULL,
	[Direction] [int] NOT NULL,
 CONSTRAINT [PK_sys_Languages_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[sys_Languages] ADD  CONSTRAINT [DF_sys_Languages_TenantId]  DEFAULT ((1)) FOR [TenantId]
GO

ALTER TABLE [dbo].[sys_Languages] ADD  DEFAULT ((0)) FOR [Direction]
GO



CREATE TABLE [dbo].[omc_ImportScenarios](
	[TenantId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CoreEntityId] [int] NOT NULL,
	[ColumnMappings] [nvarchar](MAX) NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] timestamp NOT NULL,
 CONSTRAINT [PK_omc_ImportScenarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[omc_ImportJobs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CoreEntityId] [int] NOT NULL,
	[Filename] [nvarchar](100) NOT NULL,
	[ColumnMappings] [nvarchar](MAX) NOT NULL,
	[ScenarioName] [char](1) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[ValidatedOn] [datetime] NOT NULL,
	[ImportedOn] [datetime] NOT NULL,
	[OperationStatus] [char](1) NOT NULL,
	[OperationMessage] [nvarchar](200) NULL,
	[TotalRows] [int] NOT NULL,
	[ValidRows] [int] NOT NULL,
	[NewRows] [int] NOT NULL,
	[UpdatedRows] [int] NOT NULL,
	[GlobalId] [nvarchar](50) NOT NULL,
	[RowVersion] timestamp NOT NULL,
 CONSTRAINT [PK_omc_ImportJobs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO