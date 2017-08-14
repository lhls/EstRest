USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_unidade_medida]    Script Date: 08/13/2017 20:45:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_unidade_medida]') AND type in (N'U'))
DROP TABLE [dbo].[tb_unidade_medida]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_unidade_medida]    Script Date: 08/13/2017 20:45:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tb_unidade_medida](
	[cd_unidade_medida] [int] NOT NULL,
	[ds_unidade_medida] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tb_unidade_medida] PRIMARY KEY CLUSTERED 
(
	[cd_unidade_medida] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

