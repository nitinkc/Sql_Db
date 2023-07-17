SET search_path TO problems;
SHOW search_path;

select * from google_gmail_emails;
select * from google_gmail_labels;

/* Find the number of emails received by each user under each built-in email label.
 The email labels are: 'Promotion', 'Social', and 'Shopping'. 
 Output the user along with the number of promotion, social, and shopping mails count,.
*/

SELECT ge.to_user, gl.label, count(gl.label)
FROM google_gmail_emails ge LEFT JOIN google_gmail_labels gl
ON ge.id = gl.email_id
WHERE gl.LABEL IN ('Social','Promotion','Shopping')
GROUP BY gl.LABEL, ge.to_user;


