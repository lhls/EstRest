USE [DbRestaurante]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_ingrediente_prato_tb_ingrediente]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_ingrediente_prato]'))
ALTER TABLE [dbo].[tb_ingrediente_prato] DROP CONSTRAINT [FK_tb_ingrediente_prato_tb_ingrediente]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_ingrediente_prato_tb_prato]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_ingrediente_prato]'))
ALTER TABLE [dbo].[tb_ingrediente_prato] DROP CONSTRAINT [FK_tb_ingrediente_prato_tb_prato]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_ingrediente_prato]    Script Date: 08/13/2017 20:45:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_ingrediente_prato]') AND type in (N'U'))
DROP TABLE [dbo].[tb_ingrediente_prato]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_ingrediente_prato]    Script Date: 08/13/2017 20:45:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_ingrediente_prato](
	[cd_ingrediente] [int] NOT NULL,
	[cd_prato] [int] NOT NULL,
 CONSTRAINT [PK_tb_ingrediente_prato] PRIMARY KEY CLUSTERED 
(
	[cd_ingrediente] ASC,
	[cd_prato] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tb_ingrediente_prato]  WITH CHECK ADD  CONSTRAINT [FK_tb_ingrediente_prato_tb_ingrediente] FOREIGN KEY([cd_ingrediente])
REFERENCES [dbo].[tb_ingrediente] ([cd_ingrediente])
GO

ALTER TABLE [dbo].[tb_ingrediente_prato] CHECK CONSTRAINT [FK_tb_ingrediente_prato_tb_ingrediente]
GO

ALTER TABLE [dbo].[tb_ingrediente_prato]  WITH CHECK ADD  CONSTRAINT [FK_tb_ingrediente_prato_tb_prato] FOREIGN KEY([cd_prato])
REFERENCES [dbo].[tb_prato] ([cd_prato])
GO

ALTER TABLE [dbo].[tb_ingrediente_prato] CHECK CONSTRAINT [FK_tb_ingrediente_prato_tb_prato]
GO

