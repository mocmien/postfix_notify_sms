# postfix_notify_sms
Calling to sms gateway to send notify about new message from someone ...
modify /etc/postfix/master.cf


mail_from_check   unix  -       n       n       -       -        pipe
  flags=Rq user=nobody:nobody argv=/etc/postfix/mail_from_check.sh ${size} ${sender} -- ${recipient}
  
 127.0.0.1:10025 inet n  -   -   -   -  smtpd
#    -o content_filter=
    -o content_filter=mail_from_check:dummy
    

  
Restart postfix service
