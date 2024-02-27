require 'savon'
require 'net/http'

query_body = '<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:onl="http://onlinepayment.tlc.com.ph/">
    <soapenv:Header/>
    <soapenv:Body>
        <onl:sendMror>
          <!--Optional:-->
          <token>1Fthu1CYbuaqPjUzxUXPRDze3Pc4IB0m81m/BYApVapH974OcEg5pMPA4NL6TEOZ</token>
          <!--Optional:-->
          <destMsisdn>0153056029</destMsisdn>
          <!--Optional:-->
          <amount>300</amount>
          <!--Optional:-->
          <merchantRefid>QRX147TYU852QTV963OUN789OUY</merchantRefid>
        </onl:sendMror>
    </soapenv:Body>
  </soapenv:Envelope>'
  
client = Savon.client(
    adapter: :net_http,
    endpoint: 'https://154.0.24.147/T25saW5lUGF5bWVudA',
    wsdl: File.join("FLOOZ_PAYMENT.WSDL"),
    ssl_verify_mode: :none,
    ssl_cert_file: File.join("ngserCert.pem"),
    ssl_cert_key_file: File.join("ngserprivateKey.pem"),
    ssl_cert_key_password: "P@ssw0rdNGSERM00v",
    raise_errors: true,
    log: true,
    log_level: :debug,
    pretty_print_xml: true
)
response = client.call(:send_mror , xml: query_body, soap_action: nil)
puts response