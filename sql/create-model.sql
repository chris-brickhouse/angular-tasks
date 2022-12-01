declare @app_name varchar(100) = 'Test'

DECLARE @NAME VARCHAR(100)
DECLARE @SQL NVARCHAR(300)

DECLARE CUR CURSOR FOR
  SELECT NAME
FROM SYS.TABLES
WHERE  TYPE = 'U'
  AND SCHEMA_ID = 1
  and name like 'Tasks'

OPEN CUR

FETCH NEXT FROM CUR INTO @NAME

WHILE @@FETCH_STATUS = 0
  BEGIN
  declare @Result varchar(max) = 'namespace ' + @app_name + '.Models;

			'
  select @result = @result + '[Table("' + @Name + '")]
			public class ' + replace(convert(varchar, @Name), '_','') + ' {'

  select @Result = @Result + '

		'

  select @Result = @Result + case when (Is_Identity = 1) then + '		[Key]' + char(10) else '' end + 'public ' + ColumnType + NullableSign + ' ' + ColumnNameClean + ' { get; set; }' + case when ColumnNameClean = 'TimeStamp' then ' = DateTime.Now;'
					when ColumnNameClean = 'DeleteFlag' then ' = false;'
					else ''
					end + '
					'
  from
    (
			select
      col.is_identity as Is_Identity,
      replace(col.name, ' ', '_') ColumnName,
      replace(col.name, '_', '') ColumnNameClean,
      column_id ColumnId,
      case typ.name
					when 'bigint' then 'long'
					when 'binary' then 'byte[]'
					when 'bit' then 'bool'
					when 'char' then 'string'
					when 'date' then 'DateTime'
					when 'datetime' then 'DateTime'
					when 'datetime2' then 'DateTime'
					when 'datetimeoffset' then 'DateTimeOffset'
					when 'decimal' then 'decimal'
					when 'float' then 'float'
					when 'image' then 'byte[]'
					when 'int' then 'int'
					when 'money' then 'decimal'
					when 'nchar' then 'string'
					when 'ntext' then 'string'
					when 'numeric' then 'decimal'
					when 'nvarchar' then 'string'
					when 'real' then 'double'
					when 'smalldatetime' then 'DateTime'
					when 'smallint' then 'short'
					when 'smallmoney' then 'decimal'
					when 'text' then 'string'
					when 'time' then 'TimeSpan'
					when 'timestamp' then 'DateTime'
					when 'tinyint' then 'byte'
					when 'uniqueidentifier' then 'Guid'
					when 'varbinary' then 'byte[]'
					when 'varchar' then 'string'
					else 'UNKNOWN_' + typ.name
				end ColumnType,
      case
					when col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier')
					then '?'
					else ''
				end NullableSign
    from sys.columns col
      join sys.types typ on
					col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@Name)
		) t
  order by ColumnId

  set @Result = @Result  + '
			}'

  print @Result

  --PRINT @SQL
  --EXEC Sp_executesql @SQL

  FETCH NEXT FROM CUR INTO @NAME
END

CLOSE CUR

DEALLOCATE CUR


