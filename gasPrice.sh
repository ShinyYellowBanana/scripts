#!/bin/sh
PRICE=`curl -sA 'Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0'  https://www.samsclub.com/club/melbourne-fl-sams-club/8141?xid=locator_club-details_tooltip_club-name | sed -n -e 's/^.*Unleaded<\/div><div class=\"sc-gas-price sc-club-gas-prices-price\">//p' | cut -c 1-4`
TIME=`date`
LOCATION="SAM'S CLUB"
sudo echo "$PRICE, $TIME, $LOCATION" >> /usr/share/grafana/public/testdata/gasdata.csv
sudo echo "$PRICE, $TIME, $LOCATION"
