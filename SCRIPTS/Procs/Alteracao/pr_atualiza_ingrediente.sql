USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_atualiza_ingrediente]    Script Date: 08/27/2017 09:33:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_atualiza_ingrediente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_atualiza_ingrediente]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_atualiza_ingrediente]    Script Date: 08/27/2017 09:33:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pr_atualiza_ingrediente]( @ds_xml varchar(max), 
											@cd_usuario_alteracao int)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @erro VARCHAR(500) = NULL
	DECLARE @xml XML
	DECLARE @cd_ingrediente INT
	
    set @xml = CONVERT(xml, @ds_xml)
    
    BEGIN TRAN
    
    --Insere
    
    INSERT INTO tb_ingrediente (ds_ingrediente,
							cd_unidade_medida,
							cd_usuario_inclusao,
							dt_inclusao)
    select ent.value('./ds_ingrediente[1]', 'varchar(100)') as ds_ingrediente,
			ent.value('./cd_unidade_medida[1]', 'int') as cd_unidade_medida,
			@cd_usuario_alteracao AS cd_usuario_inclusao,
			GETDATE()
	from @xml.nodes('./nIngrediente') foo(ent)
	where ent.value('./cd_ingrediente[1]', 'int') is null
	
	set @cd_ingrediente = @@Identity
	
	DECLARE @cd_estoque INT
	INSERT INTO tb_estoque (cd_ingrediente,
							dt_validade,
							nr_quantidade_atual)
    select @cd_ingrediente as cd_ingrediente,
			ent.value('./dt_validade[1]', 'datetime') as dt_validade,
			ent.value('./nr_quantidade_atual[1]', 'numeric(18,2)') as nr_quantidade_atual
	from @xml.nodes('./nIngrediente') foo(ent)
	where ent.value('./cd_ingrediente[1]', 'int') is null
	
	set @cd_estoque = @@Identity
	
	INSERT INTO tb_estoque_movimentacao (cd_estoque,
										nr_quantidade,
										fg_entrada,
										dt_lancamento,
										cd_usuario_lancamento)
    select @cd_estoque as cd_estoque,
			ent.value('./nr_quantidade_atual[1]', 'numeric(18,2)') as nr_quantidade_atual,
			1,
			GETDATE(),
			@cd_usuario_alteracao
	from @xml.nodes('./nIngrediente') foo(ent)
	where ent.value('./cd_ingrediente[1]', 'int') is null
	
	--Atualiza
	
	update i
	set ds_ingrediente = ent.value('./v_login[1]', 'varchar(100)'),
			cd_unidade_medida = ent.value('./v_senha[1]', 'int'),
			cd_usuario_alteracao = @cd_usuario_alteracao,
			dt_alteracao = GETDATE()
	from tb_ingrediente i
	join @xml.nodes('./nIngrediente') foo(ent)
		on i.cd_ingrediente =  ent.value('./cd_ingrediente[1]', 'int')
		and ISNULL(ent.value('./fg_excluido[1]', 'bit'), 0) = 0
	
	--Exclui
	IF EXISTS (select 1 
				from tb_ingrediente i
				join @xml.nodes('./nIngrediente') foo(ent)
					on i.cd_ingrediente =  ent.value('./cd_ingrediente[1]', 'int')
					and ISNULL(ent.value('./fg_excluido[1]', 'bit'), 0) = 1)
		AND ((select nr_quantidade_atual 
				from tb_estoque e
			  join @xml.nodes('./nIngrediente') foo(ent)
				on e.cd_ingrediente =  ent.value('./cd_ingrediente[1]', 'int')) > 0)
	BEGIN
		SET @erro = 'Favor zerar o estoque antes de excluir o item.'
	END
	
	update i
	set i.fg_excluido = ISNULL(ent.value('./fg_excluido[1]', 'bit'), 0),
			cd_usuario_alteracao = @cd_usuario_alteracao,
			dt_alteracao = GETDATE()
	from tb_ingrediente i
	join @xml.nodes('./nIngrediente') foo(ent)
		on i.cd_ingrediente =  ent.value('./cd_ingrediente[1]', 'int')
	
	IF @@ERROR = 0
	BEGIN
		COMMIT TRAN
		
		select isnull(ent.value('./cd_ingrediente[1]', 'int'), @cd_ingrediente)
		from @xml.nodes('./nIngrediente') foo(ent)
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		
		IF (@erro IS NOT NULL)
			RAISERROR(@erro, 10, 1)
		ELSE
			SELECT 0
	END
END

GO

