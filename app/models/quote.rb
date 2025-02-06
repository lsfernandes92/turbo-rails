class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }

  # By default, the target option will be equal to `model_name.plural``, which
  # is equal to "quotes" in the context of our `Quote`` model
  # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self } }

  # The partial default value is equal to calling to_partial_path on an instance
  # of the model. And the locals default value is equal to
  # { model_name.element.to_sym => self }.
  # after_create_commit -> { broadcast_prepend_later_to "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }
  # Those three callbacks from above are equivalent to the following single line
  broadcasts_to ->(quote) { [ quote.company, "quotes" ] }, inserts_by: :prepend

  belongs_to :company
  has_many :line_item_dates, dependent: :destroy
end
