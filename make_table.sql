drop table mail_logs;
create table mail_logs(
  status varchar(20)
  
  , title varchar(196)

  , mail_group varchar(196)
  
  , sender varchar(196)
  , recipient varchar(196)
  , mail_date varchar(196)
  , log_level varchar(20)
  , message_id  varchar(64) 
);
(status, title, mail_group, sender, recipient, mail_date, log_level, message_id )
delivered   Survey report on LIN members - response needed! [legal-impact-network]  ptepper@wclp.org   carlene@ncjustice.org  Mon, 14 Dec 2015 23:24:43 GMT info  Mon, 14 Dec 2015 23:24:43 GMT D49FF18F4ADB574AB37ABA39614026A30A375628@WCSRV2011

load data infile 'mailgun_report_final.txt' into table mail_logs FIELDS TERMINATED BY '\t';

+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| status     | varchar(20)  | YES  |     | NULL    |       |
| title      | varchar(196) | YES  |     | NULL    |       |
| mail_group | varchar(196) | YES  |     | NULL    |       |
| sender     | varchar(196) | YES  |     | NULL    |       |
| recipient  | varchar(196) | YES  |     | NULL    |       |
| mail_date  | varchar(196) | YES  |     | NULL    |       |
| log_level  | varchar(20)  | YES  |     | NULL    |       |
| message_id | varchar(64)  | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
8 rows in set (0.01 sec)
