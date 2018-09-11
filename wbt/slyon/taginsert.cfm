<cfparam default="init" name="form.action" />

<cfif form.action is 'insert'>
	
	<cfloop list="#form.tagid#" index="_x">
		<cfquery datasource="paintsquare">
		insert into site_tag_xref
			(siteID, tagID, active)
		values
			(200, #_X#, 1)
		</cfquery>
	
	</cfloop>

</cfif>

<cfquery datasource="paintsquare" name="q1">
	select *
	from pbt_tags
	where active = 1 and tagID not in (select tagid from site_tag_xref where siteID = 200)
	order by tag
</cfquery>
<form action="" method="post">
	<input type="hidden" name="action" value="insert" />
	<table>
		<tbody>
			<tr>
				<td>ID</td>
				<td>Tag</td>
			</tr>
<cfoutput query="q1">
	<tr>		
		<td><input type="checkbox" name="tagid" value="#tagid#" /></inp>#tagid#</td>
		<td>#tag#</td>
	</tr>
</cfoutput>
		</tbody>
	</table>
	<input type="submit" />
	</form>