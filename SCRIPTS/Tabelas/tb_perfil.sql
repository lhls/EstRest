USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_perfil]    Script Date: 08/13/2017 20:46:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_perfil]') AND type in (N'U'))
DROP TABLE [dbo].[tb_perfil]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_perfil]    Script Date: 08/13/2017 20:46:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tb_perfil](
	[cd_perfil] [int] NOT NULL,
	[ds_perfil] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tb_perfil] PRIMARY KEY CLUSTERED 
(
	[cd_perfil] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

