require 'irb'
binding.irb

def display
    maman = 'papa'
    puts maman
end


soap_message = <<~XML
  <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Body>
      <!-- Your SOAP message content here -->
    </soap:Body>
  </soap:Envelope>
XML

#File.join("FLOOZ_PAYMENT.WSDL"),

#0102000251 ilH2rs8ezrL6UHvInO8MfrPmnEy4VqQwxSIXz1zcaMbVvMoWqEYDA7QL5q5f8Wx6
#0153056029 1Fthu1CYbuaqPjUzxUXPRDze3Pc4IB0m81m/BYApVapH974OcEg5pMPA4NL6TEOZ

#0102000251 ilH2rs8ezrL6UHvInO8MfrPmnEy4VqQwxSIXz1zcaMbVvMoWqEYDA7QL5q5f8Wx6
#0153056029 1Fthu1CYbuaqPjUzxUXPRDze3Pc4IB0m81m/BYApVapH974OcEg5pMPA4NL6TEOZ


#client = Savon.client(
#    adapter: :net_http,
#    open_timeout: 300,
#    read_timeout: 300,
#    wsdl: "./FLOOZ_PAYMENT.WSDL",
#    endpoint: "https://merchantapi.ci-moovmoney.com/OnlinePayment/Payment", #?wsdl
#    ssl_verify_mode: :none,
#    ssl_cert_file: "/NGSER/newNgserCert.pem",
#    ssl_cert_key_file: "/NGSER/newNgserPrivateKey.pem",
#    ssl_cert_key_password: "oaDsrnHclBYDlYI",
#    log_level:   :debug,
#    log:         true
#)

#client.call(:send_mror, xml: query_body)

#soap_action: 'sendMror'
# #'https://merchantapi.ci-moovmoney.com/OnlinePayment/Payment?wsdl',