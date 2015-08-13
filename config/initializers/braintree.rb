environment = "production"

if environment == "production"
	Braintree::Configuration.environment = :production
	Braintree::Configuration.merchant_id = Rails.application.secrets.braintree_merchant_id_prod
	Braintree::Configuration.public_key = Rails.application.secrets.braintree_public_key_prod
	Braintree::Configuration.private_key = Rails.application.secrets.braintree_private_key_prod
elsif environment == "sandbox"
	Braintree::Configuration.environment = :sandbox
	Braintree::Configuration.merchant_id = Rails.application.secrets.braintree_merchant_id_sand
	Braintree::Configuration.public_key = Rails.application.secrets.braintree_public_key_sand
	Braintree::Configuration.private_key = Rails.application.secrets.braintree_private_key_sand
end