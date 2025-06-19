require 'jwt'
require 'net/http'

module JsonWebToken
  # URL interna para buscar as chaves públicas do Keycloak
  JWKS_URL = 'http://keycloak:8080/realms/diario-realm/protocol/openid-connect/certs'.freeze

  def self.verify(token)
    JWT.decode(token, nil, true, {
      algorithms: ['RS256'],
      
      # 1. 'iss' (Issuer): Deve corresponder à URL PÚBLICA do Keycloak
      iss: 'http://localhost:8081/realms/diario-realm',
      verify_iss: true,
      
      # 2. 'aud' (Audience): Deve corresponder ao ID do cliente que pediu o token
      aud: 'diario-frontend-client',
      verify_aud: true,

      # 3. 'jwks': Busca as chaves públicas para verificar a assinatura do token
      jwks: fetch_jwks
    })
  end

  private

  def self.fetch_jwks
    uri = URI.parse(JWKS_URL)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body, symbolize_names: true)
  rescue
    {}
  end
end