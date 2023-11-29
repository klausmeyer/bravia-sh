#!/usr/bin/env bash

if [[ ! -f ".env" ]];
then
  echo "Missing .env file"
  echo "Please copy .env.example to .env and fill variables"
  exit 1
fi

source .env

case "$1" in
  power) command="AAAAAQAAAAEAAAAvAw==" ;;
  input) command="AAAAAQAAAAEAAAAlAw==" ;;
  up)	   command="AAAAAQAAAAEAAAB0Aw==" ;;
  down)	 command="AAAAAQAAAAEAAAB1Aw==" ;;
  right) command="AAAAAQAAAAEAAAAzAw==" ;;
  left)	 command="AAAAAQAAAAEAAAA0Aw==" ;;
  ok)    command="AAAAAQAAAAEAAABlAw==" ;;
  back)  command="AAAAAgAAAJcAAAAjAw==" ;;
  1)     command="AAAAAQAAAAEAAAAAAw==" ;;
  2)     command="AAAAAQAAAAEAAAABAw==" ;;
  3)     command="AAAAAQAAAAEAAAACAw==" ;;
  4)     command="AAAAAQAAAAEAAAADAw==" ;;
  5)     command="AAAAAQAAAAEAAAAEAw==" ;;
  6)     command="AAAAAQAAAAEAAAAFAw==" ;;
  7)     command="AAAAAQAAAAEAAAAGAw==" ;;
  8)     command="AAAAAQAAAAEAAAAHAw==" ;;
  9)     command="AAAAAQAAAAEAAAAIAw==" ;;
  0)     command="AAAAAQAAAAEAAAAJAw==" ;;
  next)  command="AAAAAQAAAAEAAAAQAw==" ;;
  prev)  command="AAAAAQAAAAEAAAARAw==" ;;
  vinc)  command="AAAAAQAAAAEAAAASAw==" ;;
  vdec)  command="AAAAAQAAAAEAAAATAw==" ;;
  mute)  command="AAAAAQAAAAEAAAAUAw==" ;;

  *)
    echo "Unknown command"
    exit 1
  ;;
esac


request_header_content_type="Content-Type: text/xml; charset=UTF-8"
request_header_soap_action="SoapAction: ""urn:schemas-sony-com:service:IRCC:1#X_SendIRCC"""
request_header_psk="X-Auth-PSK: ${BRAVIA_SH_PSK}"

request_body="
<s:Envelope
    xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"
    s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">
    <s:Body>
        <u:X_SendIRCC xmlns:u=\"urn:schemas-sony-com:service:IRCC:1\">
            <IRCCCode>${command}</IRCCCode>
        </u:X_SendIRCC>
    </s:Body>
</s:Envelope>
"

curl -s -o /dev/null "${BRAVIA_SH_URL}/sony/IRCC" \
  -H "${request_header_content_type}" \
  -H "${request_header_soap_action}" \
  -H "${request_header_psk}" \
  -d "${request_body}"
