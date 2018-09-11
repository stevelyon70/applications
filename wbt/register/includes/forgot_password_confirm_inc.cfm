<cfsetting showdebugoutput="false">
<cfset valid = false>
<cfset message = "">
<cfset siteid = 200>

<CFSET DATE = #CREATEODBCDATETIME(NOW())#>

<cfquery name="email" datasource="#application.datasource#">
	SELECT distinct reg_users.reg_userid, reg_users.firstname, reg_users.lastname, reg_users.emailaddress, reg_users.password
	FROM reg_users
	inner join bid_users on bid_users.reguserid = reg_users.reg_userid
	inner join bid_subscription_log on bid_users.userid = bid_subscription_log.userid 
	inner join bid_user_suppliers on bid_user_suppliers.sid = bid_users.sid
	inner join user_site_xref x on x.bid_userid = bid_users.userid
	WHERE reg_users.emailaddress = <cfqueryPARAM value = "#form.emailaddress#" CFSQLType = "cf_sql_varchar" >
 	and (bid_subscription_log.effective_date <=  #date# and bid_subscription_log.expiration_date >=  #date# )
	and (bid_user_suppliers.effectivedate <= #date# and bid_user_suppliers.expirationdate >= #date#)
	and bid_users.bt_status = 1
	and x.site_id = #siteid#
	and x.active = 1
</cfquery>

<cfif email.recordcount>
	<cfset valid = true>

	<cfoutput>
	<CFMAIL
			SUBJECT="Your login information for Water BidTracker"
			FROM="webmaster@technologypub.com"			
			TO="""#email.FirstName# #email.LastName#"" <#email.emailaddress#>"
			type="html">

		<table width="550" cellspacing="0" cellpadding="0">
			<tr>
				<td width="100%">
					<table width="100%" cellspacing="0" cellpadding="0">
						<tr>
							<td width="50%">
								<a href="https://app.waterbidtracker.com">
								<img src="https://www.waterbidtracker.com/images/WBT_Logo_WebHeader_Home_DoubleSize.png" border="0" width="300">
								</a>
							</td>
							<td width="50%" align="right" valign="top">
								<p style="margin-right: 6; margin-top: 12">
								<font face="Arial, Helvetica, sans-serif" size="3" color="333399">
								<b>Password Reminder</b>
								</font></p>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>
					</table>
				<td>
			</tr>
			<tr>
				<td width="100%">
					<table width="100%" cellspacing="0" cellpadding="6">
						<tr>
							<td width="100%">
								<p><font face="Arial, Helvetica, sans-serif" size="2">
								Dear #email.firstname# #email.lastname#,<br><br>
								Here is the password reminder that you requested.<br><br>
								E-mail address: <b>#email.emailaddress#</b><br><br>
								Password: <b>#email.password#</b><br><br>
								To sign in, please <a href="https://app.waterbidtracker.com/?defaultdashboard">
								click here</a>.<br><br>
								<a href="http://www.waterbidtracker.com">Water BidTracker</a> is a publication of Technology Publishing. 
								</font></p>
							</td>
						</tr>
					</table>
				<td>
			</tr>
			<tr>
				<td width="100%">
					<table width="100%" cellspacing="0" cellpadding="0">
						<tr height="6">
							<td width="100%">
								<hr width="100%" height="6" color="333399">
							</td>
						</tr>
						<tr>
							<td width="100%">
								<p style="margin: 6"><font face="Arial, Helvetica, sans-serif" size="1">
								You received this message by submitting the password reminder form on Water BidTracker.<br><br>
								If you believe you received this message in error, please e-mail 
								<a href="mailto:webmaster@waterbidtracker.com">webmaster@waterbidtracker.com</a> or contact:<br><br>
								Technology Publishing, 1501 Reedsdale Street, Suite 2008, Pittsburgh, PA 15233, USA
								</font></p>
							</td>
						</tr>
					</table>
				<td>
			</tr>
		</table>
	</cfmail>
	</cfoutput>

</cfif>

{ "valid": <cfoutput>#valid#</cfoutput>, "message": "<cfoutput>#message#</cfoutput>"}