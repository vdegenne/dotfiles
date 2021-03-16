# i3blocks config file
#
# Please see man i3blocks for a complete reference!
# The man page is also hosted at http://vivien.github.io/i3blocks
#
# List of valid properties:
#
# align
# color
# command
# full_text
# instance
# interval
# label
# min_width
# name
# separator
# separator_block_width
# short_text
# signal
# urgent

# Global properties
#
# The top properties below are applied to every block, but can be overridden.
# Each block command defaults to the script name to avoid boilerplate.
# Change $SCRIPT_DIR to the location of your scripts!
# command=$SCRIPT_DIR/$BLOCK_NAME/$BLOCK_NAME
# command=~/.config/i3blocks/$BLOCK_NAME/$BLOCK_NAME
separator_block_width=8
markup=pango
min_width=100
separator=false

[cryptobtc]
pair=XBT/EUR
command=./cryptos.js
interval=1
min_width=0
[link1]
full_text=👁
color=#ffffff
command=google-chrome-stable https://trade.kraken.com/charts/KRAKEN:BTC-EUR 1>/dev/null
separator=false

[cryptoeth]
pair=ETH/EUR
command=./cryptos.js
interval=1
min_width=0
[link2]
full_text=👁
color=#ffffff
command=google-chrome-stable https://trade.kraken.com/charts/KRAKEN:ETH-EUR 1>/dev/null
separator=false

[cryptoxmr]
pair=XMR/EUR
command=./cryptos.js
interval=1
min_width=0
[link3]
full_text=👁
color=#ffffff
command=google-chrome-stable https://trade.kraken.com/charts/KRAKEN:XMR-EUR 1>/dev/null
separator=false


[cryptowaves]
pair=WAVES/EUR
command=./cryptos.js
interval=1
min_width=0
[linkmln]
full_text=👁
color=#ffffff
command=google-chrome-stable https://trade.kraken.com/charts/KRAKEN:MLN-EUR 1>/dev/null
separator=false


#[cryptoxrp]
#pair=XRP/EUR
#command=./cryptos.js
#interval=1
#min_width=0
#[linkxrp]
#full_text=👁
#color=#ffffff
#command=google-chrome-stable https://trade.kraken.com/charts/KRAKEN:XRP-EUR 1>/dev/null
#separator=false


[refresh]
full_text=🔄
command=pm2 restart kraken 1>/dev/null
min_width=0
