#!/bin/sh

#SAMS CLUB
PRICE=`curl https://www.samsclub.com/club/melbourne-fl-sams-club/8141?xid=locator_club-details_tooltip_club-name | sed -n -e 's/^.*Unleaded<\/div><div class=\"sc-gas-price sc-club-gas-prices-price\">//p' | cut -c 1-4`
TIME=`date`
LOCATION="SAM'S CLUB"
sudo echo "$LOCATION \$$PRICE @ $TIME\\\r\\\n"

#COSTCO
LOCATION="COSTCO"
html=$(curl -LsA "Mozilla/5.0 (Windows NT 7.1; Win64; x64; rv:74.0) Gecko/20100101 Firefox/69.0" https://www.costco.com/warehouse-locations/melbourne-fl-1450.html)
# Extract the span element containing the value
value=$(echo "$html" | grep -o '<span class="h3-style-guide">[^<]*')
# Remove the span element and extract only the value
PRICE=$(echo "$value" | sed -e 's/<span class="h3-style-guide">//' | head -n 1)
# Print the value to the console
sudo echo "$LOCATION $PRICE @ $TIME"
