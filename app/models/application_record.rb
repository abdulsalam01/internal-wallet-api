class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Constant type of transactions.
  DEBIT_TYPE = "debit"
  CREDIT_TYPE = "credit"
end
