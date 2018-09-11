<!---Inline sponsored content ad display--->
<!---cfsetting showDebugOutput="no"--->

<!---strong>
[Insert inline sponsor ad here
<cfif isdefined("contentID")>for contentID <cfoutput>#contentID#</cfoutput></cfif>
<cfif isdefined("content_typeID")>and content typeID <cfoutput>#content_typeID#</cfoutput></cfif>
]</strong--->

<!--- options for algorithm are
CFMX_COMPAT (default), AES, BLOWFISH, DES, and DESEDE --->
<cfset algorithm = "AES">
<!--- encoding options, Base64, hex, or uu --->
<cfset encoding = "hex">
<!---set the encrypt key--->
<cfset application.enc_key = "vXEEoqVBt94kWEI2heBLZQ==">

<!---Set parameters--->
<cfif not isdefined("nl_versionID")><cfset nl_versionID=0></cfif>
<cfif isdefined("trackID") and trackID is not "">
	<cfset encr_trackID = trackID>
<cfelse>
	<cfset trackID = 0>
	<cfset encr_trackID = encrypt(trackID,application.enc_key,algorithm,encoding)>
</cfif>

<!---Initialize ads--->
<cfset max_spons_ads = 1>
<cfset max_content_sponsor_ads = 1>
<cfif not isdefined("reg_userID") and isdefined("cookie.psquare")><cfset reg_userID = cookie.psquare></cfif>
<cfif not isdefined("reg_userID") and not isdefined("trackID") and isdefined("cookie.psn_user_ck") and cookie.psn_user_ck is not ""><cfset trackID = cookie.psn_user_ck></cfif>
<cfif isdefined("trackID") and trackID is not "" and (isdefined("nl_versionID") and (nl_versionid is 0 or nl_versionid gt 950))>
	<cfset trackID = URLEncodedFormat(Encrypt(trackID, application.enc_key, algorithm, encoding))>
</cfif>
<!---Create structure to hold ad details--->
<cfset pull_ads = QueryNew("companyname, nl_sponsorID, nl_adID, image_location, adname, adheadline, nl_skedID, pixel_track_url, rownumber", "varchar, integer, integer, varchar, varchar, varchar, integer, varchar, integer")>
<cfset counter=0>

<cfset day_of_week = DayOfWeek(Date)>
<!---set the week day part to identify the week range--->
<cfset weekday = DatePart("d", Date)>
<cfif weekday gte 1 and weekday lte 7>
<cfset weeknumber = 1>
<cfelseif weekday gte 8 and weekday lte 14>
<cfset weeknumber = 2>
<cfelseif weekday gte 15 and weekday lte 23>
<cfset weeknumber = 3>
<cfelseif weekday gte 24 and weekday lte 31>
<cfset weeknumber = 4>
</cfif>

<!---Pull exclusive sponsor ads--->
<cfquery name="get_content_sponsor" datasource="#application.datasource#">
	select distinct supplier_master.companyname,nl_sponsors.nl_sponsorid,nl_sponsor_ads.nl_adid,nl_sponsor_ads.image_location,nl_sponsor_ads.adname,nl_sponsor_ads.adheadline,nl_sponsors_schedule.nl_skedID,nl_sponsors_schedule.pixel_track_url
	from nl_sponsors
	inner join nl_sponsor_ads on nl_sponsor_ads.nl_sponsorid = nl_sponsors.nl_sponsorid
	inner join nl_sponsors_schedule on nl_sponsors_schedule.nl_adid = nl_sponsor_ads.nl_adid
	inner join supplier_master on supplier_master.supplierid = nl_sponsors.supplierid
	where nl_sponsors_schedule.start_date <= #date# 
	and nl_sponsors_schedule.end_date >= #date#
	and nl_sponsors_schedule.nl_positionID = 49
	and nl_sponsors_schedule.newsletterID = 35
	and nl_sponsor_ads.active = 'y'
	<cfif day_of_week is not 1 and day_of_week is not 7>and (nl_sponsors_schedule.dayofweek = #day_of_week# or nl_sponsors_schedule.dayofweek is null)</cfif>
	and (nl_sponsors_schedule.week_number = #weeknumber# or nl_sponsors_schedule.week_number is null)
	<!---and nl_sponsors_schedule.nl_skedID in (select nl_skedID from nl_sponsor_schedule_content_sponsor where gatewayID = 7 and var_contentID in (<cfqueryparam value="#contentID#" cfsqltype="cf_sql_integer" list="true">) and content_type_tagID = <cfqueryparam value="#content_typeID#" cfsqltype="cf_sql_integer">)--->
</cfquery>
<!---Random sort results and add to structure--->
<cfif get_content_sponsor.recordcount gte #max_content_sponsor_ads#>
	<cfset tot_items = #max_content_sponsor_ads#>
<cfelse>
	<cfset tot_items = #get_content_sponsor.recordcount#>
</cfif>
<!---Make a list--->
<cfset itemlistads = "">
<cfloop from="1" to="#get_content_sponsor.recordCount#" index="i">
	<cfset itemlistads = ListAppend(itemlistads, i)>
</cfloop>
<!---Randomize the list--->
<cfset randomItemsads = "">
<cfset itemCount = ListLen(itemlistads)>
<cfloop from="1" to="#itemCount#" index="i">
	<cfset random = ListGetAt(itemlistads, RandRange(1, itemCount))>
	<cfset randomItemsads = ListAppend(randomItemsads, random)>
	<cfset itemlistads = ListDeleteAt(itemlistads, ListFind(itemlistads, random))>
	<cfset itemCount = ListLen(itemlistads)>
</cfloop>
<!---Add to structure--->
<cfloop from="1" to="#tot_items#" index="i">
	<cfif listfind(#valuelist(pull_ads.nl_sponsorID)#, #get_content_sponsor.nl_sponsorID[ListGetAt(randomItemsads, i)]#) eq 0>
		<cfset newRow = QueryAddRow(pull_ads, 1)>
		<cfset counter=counter+1>
		<cfset temp = QuerySetCell(pull_ads, "companyname", "#get_content_sponsor.companyname[ListGetAt(randomItemsads, i)]#", #counter#)>
		<cfset temp = QuerySetCell(pull_ads, "nl_sponsorID", #get_content_sponsor.nl_sponsorID[ListGetAt(randomItemsads, i)]#, #counter#)>
		<cfset temp = QuerySetCell(pull_ads, "nl_adID", #get_content_sponsor.nl_adID[ListGetAt(randomItemsads, i)]#, #counter#)>
		<cfset temp = QuerySetCell(pull_ads, "image_location", "#get_content_sponsor.image_location[ListGetAt(randomItemsads, i)]#", #counter#)>
		<cfset temp = QuerySetCell(pull_ads, "adname", "#get_content_sponsor.adname[ListGetAt(randomItemsads, i)]#", #counter#)>
		<cfset temp = QuerySetCell(pull_ads, "adheadline", "#get_content_sponsor.adheadline[ListGetAt(randomItemsads, i)]#", #counter#)>
		<cfset temp = QuerySetCell(pull_ads, "nl_skedID", #get_content_sponsor.nl_skedID[ListGetAt(randomItemsads, i)]#, #counter#)>
		<cfset temp = QuerySetCell(pull_ads, "pixel_track_url", "#get_content_sponsor.pixel_track_url[ListGetAt(randomItemsads, i)]#", #counter#)>
		<cfset temp = QuerySetCell(pull_ads, "rownumber", "#counter#", #counter#)>
	</cfif>
</cfloop>

<!---DISPLAY--->
<cfif pull_ads.recordCount gt 0>
	<cfif pull_ads.recordcount gte #max_spons_ads#>
		<cfset loopmaxrow = #max_spons_ads#>
	<cfelse>
		<cfset loopmaxrow = #pull_ads.recordcount#>
	</cfif>

	<cfloop query="pull_ads" startrow="1" endrow="#loopmaxrow#">
		<cfoutput>
			<cfquery name="get_detail" datasource="#application.datasource#">
				select nl_sponsor_ads.adcontent
				from  nl_sponsor_ads 
				where nl_sponsor_ads.nl_adid = #nl_adid#
			</cfquery>
			<p style="text-align:center;">
				<span style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:11px;">
					<!---encode the nl_skedID--->
					<cfset encr_nl_skedID = encrypt(nl_skedID, application.enc_key, algorithm, encoding)>
					 <!---Link to tracking redirect--->
					 <cfif pixel_track_url is not ""><img src="#pixel_track_url#" style="display: none; width: 0; height: 0" width="0" height="0"></cfif>
					
					<cfif image_location is not "">
						<cfif isdefined("trackID") and trackID is not "">
						<a href="https://www.paintsquare.com/newsletter/tracking/bid/?trackID=#trackID#&nl_versionid=#nl_versionid#&nl_skedid=#nl_skedID#&nl_adid=#nl_adid#&redirectid=11" target="_blank">
						<cfelseif isdefined("reg_userID") and reg_userID is not "">
						<a href="https://www.paintsquare.com/newsletter/tracking/bid/?reg_userID=#reg_userID#&nl_versionid=#nl_versionid#&nl_skedid=#nl_skedID#&nl_adid=#nl_adid#&redirectid=11" target="_blank">
						<cfelse>
						<a href="https://www.paintsquare.com/newsletter/tracking/bid/?nl_versionid=#nl_versionid#&nl_skedid=#nl_skedID#&nl_adid=#nl_adid#&redirectid=11" target="_blank">
						</cfif>	
						<img border="0" src="https://www.paintsquare.com/newsletter/#image_location#" alt="#companyname#"  class="img-responsive"><br></a>	
					</cfif>
				</span>
			</p>
			<!---Record ad impression--->
			<cfquery name="impression" datasource="#application.datasource#">
				insert into nl_sponsor_site_display_log
				(nl_skedID, nl_adID, gatewayID, visitdate, remoteIP, remotehost, reg_userID, cfID, cftoken)
				values (<cfqueryparam value="#nl_skedid#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#nl_adid#" cfsqltype="cf_sql_integer">,
				2,
				<cfqueryparam value="#date#" cfsqltype="cf_sql_timestamp">,
				<cfqueryparam value="#cgi.remote_addr#" cfsqltype="cf_sql_varchar">,
				<cfqueryparam value="#cgi.remote_host#" cfsqltype="cf_sql_varchar">,
				<cfif isdefined("reg_userID") and reg_userID is not ""><cfqueryparam value="#reg_userID#" cfsqltype="cf_sql_integer"><cfelse>NULL</cfif>,
				<cfqueryparam value="#cfid#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="#cftoken#" cfsqltype="cf_sql_varchar">)
			</cfquery>
		</cfoutput>
	</cfloop>
</cfif>

