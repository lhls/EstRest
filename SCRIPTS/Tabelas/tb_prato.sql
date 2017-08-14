USE [DbRestaurante]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_prato_tb_usuario]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_prato]'))
ALTER TABLE [dbo].[tb_prato] DROP CONSTRAINT [FK_tb_prato_tb_usuario]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_prato_tb_usuario1]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_prato]'))
ALTER TABLE [dbo].[tb_prato] DROP CONSTRAINT [FK_tb_prato_tb_usuario1]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_tb_prato_fg_excluido]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tb_prato] DROP CONSTRAINT [DF_tb_prato_fg_excluido]
END

GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_prato]    Script Date: 08/13/2017 20:45:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_prato]') AND type in (N'U'))
DROP TABLE [dbo].[tb_prato]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_prato]    Script Date: 08/13/2017 20:45:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tb_prato](
	[cd_prato] [int] NOT NULL,
	[ds_prato] [varchar](255) NOT NULL,
	[fg_excluido] [bit] NOT NULL,
	[cd_usuario_inclusao] [int] NOT NULL,
	[dt_usuario_inclusao] [datetime] NOT NULL,
	[cd_usuario_alteracao] [int] NULL,
	[dt_usuario_alteracao] [datetime] NULL,
 CONSTRAINT [PK_tb_prato] PRIMARY KEY CLUSTERED 
(
	[cd_prato] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[tb_prato]  WITH CHECK ADD  CONSTRAINT [FK_tb_prato_tb_usuario] FOREIGN KEY([cd_usuario_alteracao])
REFERENCES [dbo].[tb_usuario] ([cd_usuario])
GO

ALTER TABLE [dbo].[tb_prato] CHECK CONSTRAINT [FK_tb_prato_tb_usuario]
GO

ALTER TABLE [dbo].[tb_prato]  WITH CHECK ADD  CONSTRAINT [FK_tb_prato_tb_usuario1] FOREIGN KEY([cd_usuario_inclusao])
REFERENCES [dbo].[tb_usuario] ([cd_usuario])
GO

ALTER TABLE [dbo].[tb_prato] CHECK CONSTRAINT [FK_tb_prato_tb_usuario1]
GO

ALTER TABLE [dbo].[tb_prato] ADD  CONSTRAINT [DF_tb_prato_fg_excluido]  DEFAULT ((0)) FOR [fg_excluido]
GO

