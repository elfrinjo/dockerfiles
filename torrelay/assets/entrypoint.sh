#!/bin/sh -x

sed -i 's/xxTOR_NICKxx/'"$TOR_NICK"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_CONTACTxx/'"$TOR_CONTACT"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_BRIDGExx/'"$TOR_BRIDGE"'/g' /etc/tor/torrc.relay

sed -i 's/xxTOR_OPTION1xx/'"$TOR_OPTION1"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_OPTION2xx/'"$TOR_OPTION2"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_OPTION3xx/'"$TOR_OPTION3"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_OPTION4xx/'"$TOR_OPTION4"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_OPTION5xx/'"$TOR_OPTION5"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_OPTION6xx/'"$TOR_OPTION6"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_OPTION7xx/'"$TOR_OPTION7"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_OPTION8xx/'"$TOR_OPTION8"'/g' /etc/tor/torrc.relay
sed -i 's/xxTOR_OPTION9xx/'"$TOR_OPTION9"'/g' /etc/tor/torrc.relay

tor -f /etc/tor/torrc.relay
sleep 10
