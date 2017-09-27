
/****** Object:  Table [dbo].[sp_lock_tables]    Script Date: 11/03/2010 15:50:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--drop table sp_lock_tables
CREATE TABLE [dbo].[sp_lock_tables](
	[spid] [smallint] NULL,
	[loginname] [nvarchar](20) NULL,
	[hostname] [nvarchar](50) NULL,
	[dbid] [int] NULL,
	[dbname] [nvarchar](100) NULL,
	[objId] [int] NULL,
	[ObjName] [nvarchar](128) NULL,
	[IndId] [int] NULL,
	[Type] [nvarchar](4) NULL,
	[Resource] [nvarchar](16) NULL,
	[Mode] [nvarchar](8) NULL,
	[Status] [nvarchar](5) NULL,
	[SQLscript] [nvarchar](4000) NULL,
	[DATETIME] [DATETIME] NULL,
	[BATCHID] BIGINT NULL
) ON [PRIMARY]

GO


