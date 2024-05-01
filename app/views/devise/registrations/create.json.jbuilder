# app/views/api/v1/sessions/create.json.jbuilder

json.success true
json.message "User registered successfully"
json.user do
  json.id current_user.id
  json.email current_user.email
  json.role current_user.role_names
end
