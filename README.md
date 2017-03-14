# postfix_notify_sms
Calling to sms gateway to send notify about new message from someone ...
modify /etc/postfix/master.cf

mail_from_check   unix  -       n       n       -       -        pipe
  flags=Rq user=nobody:nobody argv=/etc/postfix/mail_from_check.sh ${size} ${sender} -- ${recipient}
  
Restart postfix service
