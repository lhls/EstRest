USE [DbRestaurante]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_estoque_movimentacao_tb_estoque]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_estoque_movimentacao]'))
ALTER TABLE [dbo].[tb_estoque_movimentacao] DROP CONSTRAINT [FK_tb_estoque_movimentacao_tb_estoque]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tb_estoque_movimentacao_tb_usuario]') AND parent_object_id = OBJECT_ID(N'[dbo].[tb_estoque_movimentacao]'))
ALTER TABLE [dbo].[tb_estoque_movimentacao] DROP CONSTRAINT [FK_tb_estoque_movimentacao_tb_usuario]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_estoque_movimentacao]    Script Date: 08/13/2017 20:46:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_estoque_movimentacao]') AND type in (N'U'))
DROP TABLE [dbo].[tb_estoque_movimentacao]
GO

USE [DbRestaurante]
GO

/****** Object:  Table [dbo].[tb_estoque_movimentacao]    Script Date: 08/13/2017 20:46:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_estoque_movimentacao](
	[cd_estoque_movimentacao] [int] NOT NULL,
	[cd_estoque] [int] NOT NULL,
	[nr_quantidade] [int] NOT NULL,
	[fg_entrada] [bit] NOT NULL,
	[dt_lancamento] [datetime] NOT NULL,
	[cd_usuario_lancamento] [int] NOT NULL,
 CONSTRAINT [PK_tb_estoque_movimentacao] PRIMARY KEY CLUSTERED 
(
	[cd_estoque_movimentacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tb_estoque_movimentacao]  WITH CHECK ADD  CONSTRAINT [FK_tb_estoque_movimentacao_tb_estoque] FOREIGN KEY([cd_estoque])
REFERENCES [dbo].[tb_estoque] ([cd_estoque])
GO

ALTER TABLE [dbo].[tb_estoque_movimentacao] CHECK CONSTRAINT [FK_tb_estoque_movimentacao_tb_estoque]
GO

ALTER TABLE [dbo].[tb_estoque_movimentacao]  WITH CHECK ADD  CONSTRAINT [FK_tb_estoque_movimentacao_tb_usuario] FOREIGN KEY([cd_usuario_lancamento])
REFERENCES [dbo].[tb_usuario] ([cd_usuario])
GO

ALTER TABLE [dbo].[tb_estoque_movimentacao] CHECK CONSTRAINT [FK_tb_estoque_movimentacao_tb_usuario]
GO

