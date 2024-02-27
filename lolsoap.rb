require 'lolsoap'

# Define the SOAP message
soap_message = <<-XML
  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:onl="http://onlinepayment.tlc.com.ph/">
    <soapenv:Header/>
    <soapenv:Body>
      <onl:sendMror>
        <token>1Fthu1CYbuaqPjUzxUXPRDze3Pc4IB0m81m/BYApVapH974OcEg5pMPA4NL6TEOZ</token>
        <destMsisdn>0153056029</destMsisdn>
        <amount>300</amount>
        <merchantRefid>QRX147TYU852QTV963OUN789OUY</merchantRefid>
      </onl:sendMror>
    </soapenv:Body>
  </soapenv:Envelope>
XML

# Create a client
client = LolSoap::Client.new("https://merchantapi.ci-moovmoney.com/OnlinePayment/Payment?wsdl",
                              ssl_verify_mode: :none,
                              ssl_cert: File.read("newNgserCert.pem"),
                              ssl_cert_key: File.read("newNgserPrivateKey.pem"),
                              ssl_cert_key_password: "oaDsrnHclBYDlYI")

# Send the SOAP request
response = client.request :send_mror do |soap|
  soap.body = soap_message
end

puts response