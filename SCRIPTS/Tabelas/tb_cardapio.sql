USE [DbRestaurante]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_cardapio_tb_cuba]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_cardapio]'))
ALTER TABLE [dbo].[tb_cardapio] DROP CONSTRAINT [FK_tb_cardapio_tb_cuba]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_cardapio_tb_prato]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_cardapio]'))
ALTER TABLE [dbo].[tb_cardapio] DROP CONSTRAINT [FK_tb_cardapio_tb_prato]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_cardapio]    Script Date: 08/15/2017 19:36:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_cardapio]') AND type in (N'U'))
DROP TABLE [dbo].[tb_cardapio]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_cardapio]    Script Date: 08/15/2017 19:36:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_cardapio](
	[cd_cardapio] [int] IDENTITY(1,1) NOT NULL,
	[cd_prato] [int] NOT NULL,
	[cd_cuba] [int] NOT NULL,
	[dt_cardapio] [datetime] NOT NULL,
 CONSTRAINT [PK_tb_cardapio] PRIMARY KEY CLUSTERED 
(
	[cd_cardapio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tb_cardapio]  WITH CHECK ADD  CONSTRAINT [FK_tb_cardapio_tb_cuba] FOREIGN KEY([cd_cuba])
REFERENCES [dbo].[tb_cuba] ([cd_cuba])
GO

ALTER TABLE [dbo].[tb_cardapio] CHECK CONSTRAINT [FK_tb_cardapio_tb_cuba]
GO

ALTER TABLE [dbo].[tb_cardapio]  WITH CHECK ADD  CONSTRAINT [FK_tb_cardapio_tb_prato] FOREIGN KEY([cd_prato])
REFERENCES [dbo].[tb_prato] ([cd_prato])
GO

ALTER TABLE [dbo].[tb_cardapio] CHECK CONSTRAINT [FK_tb_cardapio_tb_prato]
GO

