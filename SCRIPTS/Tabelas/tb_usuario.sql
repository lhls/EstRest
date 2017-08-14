USE [DbRestaurante]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_usuario_tb_perfil]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_usuario]'))
ALTER TABLE [dbo].[tb_usuario] DROP CONSTRAINT [FK_tb_usuario_tb_perfil]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_tb_usuario_fg_excluido]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tb_usuario] DROP CONSTRAINT [DF_tb_usuario_fg_excluido]
END

GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_usuario]    Script Date: 08/13/2017 22:04:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_usuario]') AND type in (N'U'))
DROP TABLE [dbo].[tb_usuario]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_usuario]    Script Date: 08/13/2017 22:04:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tb_usuario](
	[cd_usuario] [int] NOT NULL,
	[ds_usuario] [varchar](50) NOT NULL,
	[ds_senha] [varchar](50) NOT NULL,
	[ds_nome] [varchar](100) NOT NULL,
	[cd_perfil] [int] NOT NULL,
	[fg_excluido] [bit] NOT NULL,
 CONSTRAINT [PK_tb_usuario] PRIMARY KEY CLUSTERED 
(
	[cd_usuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[tb_usuario]  WITH CHECK ADD  CONSTRAINT [FK_tb_usuario_tb_perfil] FOREIGN KEY([cd_perfil])
REFERENCES [dbo].[tb_perfil] ([cd_perfil])
GO

ALTER TABLE [dbo].[tb_usuario] CHECK CONSTRAINT [FK_tb_usuario_tb_perfil]
GO

ALTER TABLE [dbo].[tb_usuario] ADD  CONSTRAINT [DF_tb_usuario_fg_excluido]  DEFAULT ((0)) FOR [fg_excluido]
GO

