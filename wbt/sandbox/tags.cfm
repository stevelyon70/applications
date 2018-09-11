<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Untitled Document</title>
</head>

<body>
	<cfquery datasource="#application.datasource#" name="q1" timeout="1500">
		select distinct top 1000 b.bidID
		from pbt_project_master_cats ppmc inner join pbt_project_master_gateway b on b.bidID = ppmc.bidID
		where 0=0 
			and ppmc.tagID = 12 
			and paintpublishdate >= '2017-07-01'
			and not b.bidid in (select bidid from pbt_project_master_cats where tagid = 677 and bidlogid > 8038721)
		order by b.bidid
	</cfquery>
	<cfoutput query="q1">
	<cfquery datasource="#application.datasource#">
		insert into pbt_project_master_cats
		(bidid, tagid)
		values
		(#bidid#, 677)
	</cfquery>
	</cfoutput>
	<cfoutput>
	#q1.recordcount#
	</cfoutput>
</body>
</html>