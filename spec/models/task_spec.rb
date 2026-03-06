require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) {User.create!(email: "teste@teste.com", password: "123456")}
  let(:user2){User.create!(email: "teste2@teste.com", password: "123456")}
  let(:admin){User.create!(email: "teste@admin", password: "123456", admin: true)}
  let(:category) {Category.create!(name: "categoria 1", user: user)}
  let(:category2) {Category.create!(name: "categoria 2", user: user2)}

  context "Criação correta de uma task" do
    it "sucesso ao criar tarefa" do
      task = Task.new(title: "tarefa user 1", description: "descrição da tarefa 1",
       end_date: Date.today, status: "pending", category: category, user: user)
      task.valid?
      expect(task).to be_valid
    end
  end
  context "falha ao criar uma task" do
    it "falta de campos obrigatórios" do
      task = Task.new(title: "", description: "", end_date: nil, status: nil, category: nil, user: nil)
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
      expect(task.errors[:description]).to include("can't be blank")
      expect(task.errors[:end_date]).to include("can't be blank")
      expect(task.errors[:status]).to include("can't be blank")
      expect(task.errors[:category]).to include("must exist")
      expect(task.errors[:user]).to include("must exist")
    end
  end
  context "editar task" do
    it "sucesso ao editar tarefa" do
      task = Task.create!(title: "tarefa user 2", description: "descrição da tarefa 1",
      end_date: Date.today, status: "pending", category: category2, user: user2)
      task.description = "descrição editada"
      task.end_date = Date.tomorrow
      task.status = "in_progress"
      task.save!
      expect(task.description).to eq("descrição editada")
      expect(task.end_date.to_date).to eq(Date.tomorrow)
      expect(task.status).to eq("in_progress")
    end
  end
  context "isolamento de dados entre usuários" do
    it "usuário não pode associar tarefa a categoria de outro usuário" do
      task = Task.new(title: "tarefa user 2", description: "descrição da tarefa 1",
       end_date: Date.today, status: "pending", category: category, user: user2)
      task.valid?
      expect(task.errors[:category_id]).to include("Categoria inválida. Apenas suas categorias podem ser associadas.")
    end
  end
  context "excluir tarefa" do
    it "sucesso ao excluir tarefa" do
      task = Task.create!(title: "tarefa user 1", description: "descrição da tarefa 1",
      end_date: Date.today, status: "pending", category: category, user: user)
      expect { task.destroy }.to change(Task, :count).by(-1)
    end
  end
end

