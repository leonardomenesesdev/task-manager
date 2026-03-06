class Task < ApplicationRecord
    belongs_to :user
    belongs_to :category
    enum :status, { pending: 0, in_progress: 1, completed: 2 }
    validates :title, :status, :end_date, :description, presence: true
    validate :valid_category

    # um usuário só pode associar tarefas às suas próprias categorias
    def valid_category
        if category_id.present? && category.user_id != user.id
            errors.add(:category_id, "Categoria inválida. Apenas suas categorias podem ser associadas.")
        end
    end
end
