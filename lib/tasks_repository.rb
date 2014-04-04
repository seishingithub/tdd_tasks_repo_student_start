require 'sequel'

class TasksRepository
  def initialize(db)
    @tasks_table = db[:tasks]
  end

  def create(attributes)
    @tasks_table.insert(attributes)
  end

  def all
    @tasks_table.to_a
  end

  def find(id)
    filter_by_id(id).to_a.first
  end

  def update(id, attributes)
    filter_by_id(id).update(attributes)
  end

  def delete(id)
    filter_by_id(id).delete
  end

  private
  def filter_by_id(id)
    @tasks_table.where(:id => id)
  end
end