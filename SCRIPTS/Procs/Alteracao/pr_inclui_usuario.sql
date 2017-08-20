USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_inclui_usuario]    Script Date: 08/19/2017 14:01:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_inclui_usuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_inclui_usuario]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_inclui_usuario]    Script Date: 08/19/2017 14:01:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pr_inclui_usuario]( @ds_xml varchar(max), 
											@cd_usuario_alteracao int)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @xml XML
	DECLARE @cd_usuario INT
	
    set @xml = CONVERT(xml, @ds_xml)
    
    BEGIN TRAN
    
    INSERT INTO tb_usuario (ds_usuario,
							ds_senha,
							ds_nome,
							cd_perfil)
    select ent.value('./v_login[1]', 'varchar(100)') as ds_login,
			ent.value('./v_senha[1]', 'varchar(100)') as v_senha,
			ent.value('./ds_nome[1]', 'varchar(100)') as ds_nome,
			ent.value('./cd_perfil[1]', 'int') as cd_perfil
	from @xml.nodes('./nUsuario') foo(ent)
	where ent.value('./cd_usuario[1]', 'int') is null
	
	set @cd_usuario = @@Identity
	
	update u
	set ds_usuario = ent.value('./v_login[1]', 'varchar(100)'),
			ds_senha = ent.value('./v_senha[1]', 'varchar(100)'),
			ds_nome = ent.value('./ds_nome[1]', 'varchar(100)'),
			cd_perfil = ent.value('./cd_perfil[1]', 'int')
	from tb_usuario u
	join @xml.nodes('./nUsuario') foo(ent)
		on u.cd_usuario =  ent.value('./cd_usuario[1]', 'int')
		and ISNULL(ent.value('./fg_excluido[1]', 'bit'), 0) = 0
	
	update u
	set u.fg_excluido = ISNULL(ent.value('./fg_excluido[1]', 'bit'), 0)
	from tb_usuario u
	join @xml.nodes('./nUsuario') foo(ent)
		on u.cd_usuario =  ent.value('./cd_usuario[1]', 'int')
	
	IF @@ERROR = 0
	BEGIN
		COMMIT TRAN
		
		select isnull(ent.value('./cd_usuario[1]', 'int'), @cd_usuario)
		from @xml.nodes('./nUsuario') foo(ent)
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		
		select 0
	END
END
GO
