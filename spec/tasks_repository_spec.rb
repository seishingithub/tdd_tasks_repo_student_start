require 'spec_helper'

require 'tasks_repository'

describe TasksRepository do
  let(:db) { Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_test') }

  before do
    db.create_table :tasks do
      primary_key :id
      String :name
    end

    @repo = TasksRepository.new(db)
  end

  after do
    db.drop_table :tasks
  end

  it 'allows for creating of a task' do
    @repo.create({:name => "Do some stuff"})
    @repo.create({:name => "Do some other stuff"})
    expected_tasks = [
        {:id => 1, :name => "Do some stuff"},
        {:id => 2, :name => "Do some other stuff"}
    ]
    expect(@repo.all).to eq expected_tasks
  end

  it 'allows for finding a task by id' do
    @repo.create({:name => "Do some stuff"})
    @repo.create({:name => "Do some other stuff"})
    expected_task =
        {:id => 1, :name => "Do some stuff"}
    expect(@repo.find(1)).to eq expected_task
  end

  it 'allows updating a task' do
    @repo.create({:name => "Do some stuff"})
    @repo.update(1, {:name => "Do more stuff"})
    expected_task =
        {:id => 1, :name => "Do more stuff"}
    expect(@repo.find(1)).to eq expected_task
  end

  it 'allow deleting of a task' do
    @repo.create({:name => "Do some stuff"})
    @repo.create({:name => "Do some more stuff"})
    @repo.delete(1)
    expected_task =
        [{:id => 2, :name => "Do some more stuff"}]
    expect(@repo.all).to eq expected_task
  end

end