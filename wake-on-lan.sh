#!/bin/bash

# Endereço MAC do computador alvo (sem dois pontos ou hífens)
MAC_ADDRESS="d843ae6e1bf6"


BROADCAST_ADDRESS1="10.0.0.255" # Endereço de broadcast IPv4
BROADCAST_ADDRESS2="255.255.255.255" # Endereço de broadcast IPv4
BROADCAST_ADDRESS3="ff02::1" # Endereço de broadcast IPv6

PORT_DISCARD=9
PORT_WOL=47999

# Constrói a string do pacote mágico
# 6 bytes de FF
MAGIC_PACKET="FFFFFFFFFFFF"
# 16 repetições do MAC
for i in {1..16}; do
  MAGIC_PACKET+=$MAC_ADDRESS
done

echo "Pacote mágico: $MAGIC_PACKET"
# Converte a string hexadecimal em bytes (usando \x para caracteres hexadecimais)
# Exemplo: AABBCC -> \xAA\xBB\xCC
HEX_ESCAPED_MAGIC_PACKET=$(echo "$MAGIC_PACKET" | sed -e 's/../\\x&/g')

echo "Pacote mágico em formato hexadecimal: $HEX_ESCAPED_MAGIC_PACKET"

echo -ne "$HEX_ESCAPED_MAGIC_PACKET" | socat - UDP-DATAGRAM:"$BROADCAST_ADDRESS1":"$PORT_DISCARD",broadcast
echo "Pacote mágico WoL enviado para $MAC_ADDRESS via IPv4 na porta $PORT_DISCARD via $BROADCAST_ADDRESS1"
for i in {1..6}; do
  echo -ne "$HEX_ESCAPED_MAGIC_PACKET" | socat - UDP-DATAGRAM:"$BROADCAST_ADDRESS1":"$PORT_WOL",broadcast
done
echo "Pacote mágico WoL enviado para $MAC_ADDRESS via IPv4 na porta $PORT_WOL via $BROADCAST_ADDRESS1"


# echo -ne "$HEX_ESCAPED_MAGIC_PACKET" | socat - UDP-DATAGRAM:"$BROADCAST_ADDRESS2":"$PORT_DISCARD",broadcast
# echo "Pacote mágico WoL enviado para $MAC_ADDRESS via IPv4 na porta $PORT_DISCARD via $BROADCAST_ADDRESS2"
# for i in {1..6}; do
#   echo -ne "$HEX_ESCAPED_MAGIC_PACKET" | socat - UDP-DATAGRAM:"$BROADCAST_ADDRESS2":"$PORT_WOL",broadcast
# done
# echo "Pacote mágico WoL enviado para $MAC_ADDRESS via IPv4 na porta $PORT_WOL via $BROADCAST_ADDRESS2"


# echo -ne "$HEX_ESCAPED_MAGIC_PACKET" | socat - UDP-DATAGRAM:"$BROADCAST_ADDRESS3":"$PORT_DISCARD",broadcast
# echo "Pacote mágico WoL enviado para $MAC_ADDRESS via IPv4 na porta $PORT_DISCARD via $BROADCAST_ADDRESS3"
# for i in {1..6}; do
#   echo -ne "$HEX_ESCAPED_MAGIC_PACKET" | socat - UDP-DATAGRAM:"$BROADCAST_ADDRESS3":"$PORT_WOL",broadcast
# done
# echo "Pacote mágico WoL enviado para $MAC_ADDRESS via IPv4 na porta $PORT_WOL via $BROADCAST_ADDRESS3"
