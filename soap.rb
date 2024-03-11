require 'savon'
require 'net/http'
require 'openssl'
require 'base64'
=begin
chars_source = %w{ 9 8 7 6 5 4 3 2 1 0 }
code = (0...3).map{ chars_source.to_a[rand(chars_source.size)] }.join
salt = Time.now.to_i.to_s
code += salt
=end

# plaintext = "0:myusername:mypassword"
# plaintext = "0:NGSER_DEPOT:jG8hX5QFUHBz1FdYDumc"
=begin
plaintext = "#{code}:NGSER:m5n6a2bEXH2Jyo6yAZ1v"

puts "Plain Text = #{plaintext}"

plain = plaintext.encode('UTF-8')
key = ["B6280F633A862E98D95155A9C903F73A3B8C917DAE300E5E8E02C02F9FBDBD3A"].pack('H*')


# Si la longueur de la clé est supérieure à 16 octets, tronquer
key = key[0..15] if key.length > 16

puts "Plain Hex = #{plain.unpack('H*').first}"

cipher = OpenSSL::Cipher.new('AES-128-CBC')
cipher.encrypt
cipher.key = key
iv = cipher.random_iv
encrypted = cipher.update(plain) + cipher.final

puts "Encrypted Hex = #{encrypted.unpack('H*').first}"

encode = Base64.encode64(encrypted)
puts "Token Text = #{encode}"

=end
=begin
encode = "aEO03JkP5TMgaGEdtOmzoaFifSLH9m4hcEhU4p06layThur55/psANxvWKfacvBs"
query_body = %Q[<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:onl="http://onlinepayment.tlc.com.ph/">
    <soapenv:Header/>
    <soapenv:Body>
        <onl:sendMror>
          <!--Optional:-->
          <token>#{encode}</token>
          <!--Optional:-->
          <destMsisdn>2250170070415</destMsisdn>
          <!--Optional:-->
          <amount>200</amount>
          <!--Optional:-->
          <merchantRefid>QRX147TYU852Q859612378</merchantRefid>
        </onl:sendMror>
    </soapenv:Body>
  </soapenv:Envelope>]
  
client1 = Savon.client(
  adapter: :net_http,
  endpoint: 'https://merchantapi.ci-moovmoney.com/OnlinePayment/Payment?wsdl',
  wsdl: "https://merchantapi.ci-moovmoney.com/OnlinePayment/Payment?wsdl",  #File.join("FLOOZ_PAYMENT.WSDL"),
  ssl_verify_mode: :none,
  ssl_cert_file: File.join("newNgserCert.pem"),
  ssl_cert_key_file: File.join("newNgserPrivateKey.pem"),
  ssl_cert_key_password: "oaDsrnHclBYDlYI",
  raise_errors: true,
  log: true,
  log_level: :debug,
  pretty_print_xml: true
)    
=end 
# xmlns:psi="http://psi.ph.floozonline.com/">
=begin
encode2 = "CIuvpKEsQ25skgfx0xmA6RsHxmy5i6Et+ptGlINEPq+/Or0W9bki+FzaIMeBXSa0"
  query_body2 = %Q[<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:psi="http://psi.ph.floozonline.com/">
      <soapenv:Header/>
      <soapenv:Body>
        <psi:doCashin>
          <!--Optional:-->
          <FloozTransactionRequest>
            <token>#{encode2}</token>
            <customerData>2250170070415</customerData>
            <amount>100</amount>
            <operationId>QRX147TYU852Q859612378YTREAUOPLKJHGFDSE</operationId>
            <operationDesc>Credit de compte Moov Money</operationDesc>
          </FloozTransactionRequest>
        </psi:doCashin>
      </soapenv:Body>
    </soapenv:Envelope>]

client2 = Savon.client(
  adapter: :net_http,
  endpoint: 'https://merchantapi.ci-moovmoney.com/FloozOnlineTransactions/FloozOnline?wsdl',
  wsdl: File.join('FLOOZ_ONLINE.WSDL'),
  ssl_verify_mode: :none,
  ssl_cert_file: File.join("newDepotNgserCert.pem"),
  ssl_cert_key_file: File.join("newNgserDepotPrivateKey.pem"),
  ssl_cert_key_password: "oXFz1SoJzybm8yo",
  raise_errors: true,
  log: true,
  log_level: :debug,
  pretty_print_xml: true
)


#response = client.call(:send_mror , xml: query_body, soap_action: nil)
response = client2.call(:do_cashin , xml: query_body2, soap_action: nil)
puts response

=end

### SBEDAI TEST

# Checkout 
encode = "fc3X2HYaSATCNxPwG8GzriU9vqIznvmOYjFnMP5srZ1PHV9B5gfm2adgC/HTFGTX"
query_body = %Q[<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:onl="http://onlinepayment.tlc.com.ph/">
    <soapenv:Header/>
    <soapenv:Body>
        <onl:sendMror>
          <!--Optional:-->
          <token>#{encode}</token>
          <!--Optional:-->
          <destMsisdn>2250101038387</destMsisdn>
          <!--Optional:-->
          <amount>200</amount>
          <!--Optional:-->
          <merchantRefid>QRX147TYU852Q8596123148796325874111111144477777779982369874512278</merchantRefid>
        </onl:sendMror>
    </soapenv:Body>
  </soapenv:Envelope>]
  
client = Savon.client(
  adapter: :net_http,
  endpoint: 'https://merchantapi.ci-moovmoney.com/OnlinePayment/Payment?wsdl',
  wsdl: "https://merchantapi.ci-moovmoney.com/OnlinePayment/Payment?wsdl",  #File.join("FLOOZ_PAYMENT.WSDL"),
  ssl_verify_mode: :none,
  ssl_cert_file: File.join("snedai/checkout/snedaiCert.pem"),
  ssl_cert_key_file: File.join("snedai/checkout/SnedaiPrivateKey.pem"),
  ssl_cert_key_password: "4UVm9P24HCWopcpk",
  raise_errors: true,
  log: true,
  log_level: :debug,
  pretty_print_xml: true
)

response = client.call(:send_mror , xml: query_body, soap_action: nil)
puts response


