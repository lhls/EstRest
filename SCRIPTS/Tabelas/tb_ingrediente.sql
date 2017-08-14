USE [DbRestaurante]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_ingrediente_tb_unidade_medida]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_ingrediente]'))
ALTER TABLE [dbo].[tb_ingrediente] DROP CONSTRAINT [FK_tb_ingrediente_tb_unidade_medida]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_ingrediente_tb_usuario]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_ingrediente]'))
ALTER TABLE [dbo].[tb_ingrediente] DROP CONSTRAINT [FK_tb_ingrediente_tb_usuario]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_ingrediente_tb_usuario1]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_ingrediente]'))
ALTER TABLE [dbo].[tb_ingrediente] DROP CONSTRAINT [FK_tb_ingrediente_tb_usuario1]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_tb_ingrediente_fg_excluido]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tb_ingrediente] DROP CONSTRAINT [DF_tb_ingrediente_fg_excluido]
END

GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_ingrediente]    Script Date: 08/13/2017 20:44:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_ingrediente]') AND type in (N'U'))
DROP TABLE [dbo].[tb_ingrediente]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_ingrediente]    Script Date: 08/13/2017 20:44:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tb_ingrediente](
	[cd_ingrediente] [int] NOT NULL,
	[ds_ingrediente] [varchar](100) NOT NULL,
	[fg_excluido] [bit] NOT NULL,
	[cd_unidade_medida] [int] NOT NULL,
	[cd_usuario_inclusao] [int] NOT NULL,
	[dt_inclusao] [datetime] NOT NULL,
	[cd_usuario_alteracao] [int] NULL,
	[dt_alteracao] [datetime] NULL,
 CONSTRAINT [PK_tb_ingrediente] PRIMARY KEY CLUSTERED 
(
	[cd_ingrediente] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[tb_ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_tb_ingrediente_tb_unidade_medida] FOREIGN KEY([cd_unidade_medida])
REFERENCES [dbo].[tb_unidade_medida] ([cd_unidade_medida])
GO

ALTER TABLE [dbo].[tb_ingrediente] CHECK CONSTRAINT [FK_tb_ingrediente_tb_unidade_medida]
GO

ALTER TABLE [dbo].[tb_ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_tb_ingrediente_tb_usuario] FOREIGN KEY([cd_usuario_alteracao])
REFERENCES [dbo].[tb_usuario] ([cd_usuario])
GO

ALTER TABLE [dbo].[tb_ingrediente] CHECK CONSTRAINT [FK_tb_ingrediente_tb_usuario]
GO

ALTER TABLE [dbo].[tb_ingrediente]  WITH CHECK ADD  CONSTRAINT [FK_tb_ingrediente_tb_usuario1] FOREIGN KEY([cd_usuario_inclusao])
REFERENCES [dbo].[tb_usuario] ([cd_usuario])
GO

ALTER TABLE [dbo].[tb_ingrediente] CHECK CONSTRAINT [FK_tb_ingrediente_tb_usuario1]
GO

ALTER TABLE [dbo].[tb_ingrediente] ADD  CONSTRAINT [DF_tb_ingrediente_fg_excluido]  DEFAULT ((0)) FOR [fg_excluido]
GO

