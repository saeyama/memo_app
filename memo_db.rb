# Description/Explanation of Memodb class
class Memodb
  def initialize
    @connection = PG.connect(dbname: 'memo_db')
  end

  def table
    @connection.exec('SELECT * FROM Memo ORDER BY id')
  end

  def table_process(crud_content, *row)
    @connection.exec(crud_content, row)
  end

  def row_create(content)
    table_process('INSERT INTO Memo(content) VALUES ($1) RETURNING id', content)
  end

  def row_find_id(id)
    table_process('SELECT * FROM Memo WHERE id=$1', id)
  end

  def row_update(content, id)
    table_process('UPDATE Memo SET content=$1 WHERE id=$2;', content, id)
  end

  def row_delete(id)
    table_process('DELETE FROM Memo WHERE id=$1;', id)
  end
end
