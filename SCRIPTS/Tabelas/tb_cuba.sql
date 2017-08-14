USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_cuba]    Script Date: 08/13/2017 20:46:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_cuba]') AND type in (N'U'))
DROP TABLE [dbo].[tb_cuba]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_cuba]    Script Date: 08/13/2017 20:46:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tb_cuba](
	[cd_cuba] [int] NOT NULL,
	[ds_cuba] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tb_cuba] PRIMARY KEY CLUSTERED 
(
	[cd_cuba] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

