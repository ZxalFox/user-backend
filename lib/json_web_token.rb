# ./user-backend/app/lib/json_web_token.rb
require 'jwt'
require 'net/http'

module JsonWebToken
  # URL onde nosso Keycloak (diario-realm) expõe suas chaves públicas (JWKS)
  # Usamos o nome do serviço 'keycloak' e a porta interna '8080'
  JWKS_URL = 'http://keycloak:8080/realms/diario-realm/protocol/openid-connect/certs'.freeze

  def self.verify(token)
    JWT.decode(token, nil, true, {
      algorithms: ['RS256'],
      iss: 'http://localhost:8080/realms/diario-realm', # URL exata do 'issuer'
      verify_iss: true,
      aud: 'account', # O 'audience' padrão do Keycloak. Pode precisar de ajuste.
      verify_aud: true,
      jwks: fetch_jwks
    })
  end

  def self.fetch_jwks
    uri = URI.parse(JWKS_URL)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body, symbolize_names: true)
  rescue
    # Em caso de falha (ex: Keycloak offline), retorna um hash vazio
    {}
  end
end