resource "aws_ssm_parameter" "line_priv_jwk" {
  name  = local.ssm_parameter_line_priv_jwk_name
  type  = "SecureString"
  value = "{}" # 手動で設定するため空のJSONオブジェクトを渡す(JWK形式の秘密鍵)

  lifecycle {
    ignore_changes = [value]
  }
}