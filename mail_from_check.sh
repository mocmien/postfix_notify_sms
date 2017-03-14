#!/bin/bash

# FILTER_DIR: Temporary directory we will use to verify the emails.
#             be sure the user nobody (or whichever specified at
#             Postfix master.cf) has access to get there and write!
FILTER_DIR="/var/spool/postfix/filter"
#
# ATTACH: Attach the full source of the offending email on the warning email.
ATTACH="yes"

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
SENDMAIL="`which sendmail` -G -i"
POSTLOG="`which postlog`"
FILE=".mfc.$$.`date +%Y%m%d%H%M%S`"

#if [ -n "`echo $@ | grep "\--"`" ]; then
trap "rm -f $FILTER_DIR/$FILE" 0 1 2 3 4 6 8 9 15 20
cd $FILTER_DIR || { $POSTLOG -t postfix/mail_from_check ERROR: $FILTER_DIR does not exist!; exit 71; }
cat > $FILE || { $POSTLOG -t postfix/mail_from_check ERROR: Cannot save mail to file; exit 71; }

size="$1"
from="$2"
if [ "$from" != "--" ]; then
    shift
  else
    $from=""
fi
  shift ; shift

  to="$@"

if  [ "$from" = "abc@abc.com" ] || [ "$from" = "xfz@abc.com" ]; then
        for i in `echo $to`
        do
                curl "http://smsgateway.com/sendsms.php?from="$from"&to="$i""
        done
fi

$SENDMAIL -f $from -- $to < $FILE
