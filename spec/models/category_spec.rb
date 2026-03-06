require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) {User.create!(email: "teste@teste.com", password: "123456")}
  let(:user2){User.create!(email: "teste2@teste.com", password: "123456")}
  let(:admin){User.create!(email: "teste@admin", password: "123456", admin: true)}

  context "Criação correta de uma categoria" do
    it "sucesso ao criar categoria" do
      category = Category.new(name: "categoria 1", user: user)
      category.valid?
      expect(category).to be_valid
    end
  end
  context "falha ao criar uma categoria" do
    it "falta de campos obrigatórios" do
      category = Category.new(name: "", user: nil)
      category.valid?
      expect(category.errors[:name]).to include("can't be blank")
      expect(category.errors[:user]).to include("must exist")
    end
  end
  context "editar categoria" do
    it "sucesso ao editar categoria" do
      category = Category.create!(name: "categoria 1", user: user)
      category.name = "categoria editada"
      category.save!
      expect(category.name).to eq("categoria editada")
    end
  end
  context "excluir categoria" do
    it "sucesso ao excluir categoria" do
      category = Category.create!(name: "categoria 1", user: user)
      expect { category.destroy }.to change(Category, :count).by(-1)
    end
  end
end
