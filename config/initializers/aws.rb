AWS.config(
	access_key_id: Rails.application.secrets.aws_access_id,
	secret_access_key: Rails.application.secrets.aws_secret_id
)