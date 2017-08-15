USE [DbRestaurante]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_estoque_tb_ingrediente]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_estoque]'))
ALTER TABLE [dbo].[tb_estoque] DROP CONSTRAINT [FK_tb_estoque_tb_ingrediente]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_tb_estoque_nr_quantidade_atual]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tb_estoque] DROP CONSTRAINT [DF_tb_estoque_nr_quantidade_atual]
END

GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_estoque]    Script Date: 08/15/2017 19:36:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_estoque]') AND type in (N'U'))
DROP TABLE [dbo].[tb_estoque]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_estoque]    Script Date: 08/15/2017 19:36:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_estoque](
	[cd_estoque] [int] IDENTITY(1,1) NOT NULL,
	[cd_ingrediente] [int] NOT NULL,
	[dt_validade] [datetime] NOT NULL,
	[nr_quantidade_atual] [int] NOT NULL,
 CONSTRAINT [PK_tb_estoque] PRIMARY KEY CLUSTERED 
(
	[cd_estoque] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tb_estoque]  WITH CHECK ADD  CONSTRAINT [FK_tb_estoque_tb_ingrediente] FOREIGN KEY([cd_ingrediente])
REFERENCES [dbo].[tb_ingrediente] ([cd_ingrediente])
GO

ALTER TABLE [dbo].[tb_estoque] CHECK CONSTRAINT [FK_tb_estoque_tb_ingrediente]
GO

ALTER TABLE [dbo].[tb_estoque] ADD  CONSTRAINT [DF_tb_estoque_nr_quantidade_atual]  DEFAULT ((0)) FOR [nr_quantidade_atual]
GO

