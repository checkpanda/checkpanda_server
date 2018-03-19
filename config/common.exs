use Mix.Config

# データの書式
config :checkpanda_server,
  screen_name_length_min: 4,
  screen_name_length_max: 32,
  name_length_min: 1,
  name_length_max: 32,
  screen_name_format: ~r/^[a-zA-Z0-9_]+$/,
  api_token_length: 36,
  # LINE ID と Access Token は仕様がよくわからないのでとりあえず1文字以上の任意文字列とする
  line_id_length_min: 1,
  line_token_length_min: 1


