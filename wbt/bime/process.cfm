<cfset the_dsn = "paintsquare">
<cfsetting showdebugoutput="false">

<cfparam name="url.bDate" default= '2017-01-01' />
<cfparam name="url.eDate" default= '2017-12-31' />

<!---
get the 3 months based on bDate
get first and last days of those months
set vars for each
--->
<cfset startMonth = month(bDate) />

<cfset month1 = url.bDate />
<cfset month2 = dateadd('m', +1, '#url.bDate#') />
<cfset month3 = dateadd('m', +2, '#url.bDate#') />

<cfset month1FirstDay = '#year(month1)#-#month(month1)#-01'/>
<cfset month1LastDay = '#year(month1)#-#month(month1)#-#DaysInMonth(month1)#'/>

<cfset month2FirstDay = '#year(month2)#-#month(month2)#-01'/>
<cfset month2LastDay = '#year(month2)#-#month(month2)#-#DaysInMonth(month2)#'/>

<cfset month3FirstDay = '#year(month3)#-#month(month3)#-01'/>
<cfset month3LastDay = '#year(month3)#-#month(month3)#-#DaysInMonth(month3)#'/>
<cfswitch expression="#url.main#">
	<cfcase value="mpab">
		<cfswitch expression="#url.sub#">
			<cfcase value="volumeByMonth">
				<cfquery datasource="paintsquare" name="qTotalPerQuarterPerMonth" result="r1">
					--total dollars per month
					select sum(mth1.value) as total, #DateFormat(month1, "m")# as mth, '#DateFormat(month1, "mmm")# #DateFormat(month1, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' 
				and [Sub Categories] like '%Bridges and Tunnels%'
					group by bidid, paintpublishdate, amount) as mth1

					union 

					select sum(mth1.value) as total, #DateFormat(month2, "m")# as mth, '#DateFormat(month2, "mmm")# #DateFormat(month2, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and [Sub Categories] like '%Bridges and Tunnels%'
					group by bidid, paintpublishdate, amount) as mth1

					union

					select sum(mth1.value) as total, #DateFormat(month3, "m")# as mth, '#DateFormat(month3, "mmm")# #DateFormat(month3, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month3FirstDay# 00:00:00' and paintpublishdate <= '#month3LastDay# 23:59:59' 
				and [Sub Categories] like '%Bridges and Tunnels%'
					group by bidid, paintpublishdate, amount) as mth1

					order by mth
				</cfquery>
					{
						"foot": [<cfoutput query="qTotalPerQuarterPerMonth">"#mthname#"<cfif currentrow neq qTotalPerQuarterPerMonth.recordcount>,</cfif></cfoutput>],
						"items": [<cfoutput query="qTotalPerQuarterPerMonth">#total#<cfif currentrow neq qTotalPerQuarterPerMonth.recordcount>,</cfif></cfoutput>]
					}
			</cfcase>
			<cfcase value="valueByMonth">
				<cfquery datasource="paintsquare" name="qAvgContractValuePerMonth" result="r2">
					select sum(mth1.value) as total, #DateFormat(month1, "m")# as mth, '#DateFormat(month1, "mmm")# #DateFormat(month1, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59'
						and [Sub Categories] like '%Bridges and Tunnels%' ) as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' 
						and [Sub Categories] like '%Bridges and Tunnels%'
					group by bidid, paintpublishdate, amount) as mth1

					union 

					select sum(mth1.value) as total, #DateFormat(month2, "m")# as mth, '#DateFormat(month2, "mmm")# #DateFormat(month2, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and [Sub Categories] like '%Bridges and Tunnels%') as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and [Sub Categories] like '%Bridges and Tunnels%'
					group by bidid, paintpublishdate, amount) as mth1

					union

					select sum(mth1.value) as total, #DateFormat(month3, "m")# as mth, '#DateFormat(month3, "mmm")# #DateFormat(month3, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and [Sub Categories] like '%Bridges and Tunnels%') as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month3FirstDay# 00:00:00' and paintpublishdate <= '#month3LastDay# 23:59:59' 
				and [Sub Categories] like '%Bridges and Tunnels%'
					group by bidid, paintpublishdate, amount) as mth1

					order by mth
				</cfquery>

					{
						"foot": [<cfoutput query="qAvgContractValuePerMonth">"#mthname#"<cfif currentrow neq qAvgContractValuePerMonth.recordcount>,</cfif></cfoutput>],
						"items": [<cfoutput query="qAvgContractValuePerMonth">#numberformat(total/bidcount,'00')#<cfif currentrow neq qAvgContractValuePerMonth.recordcount>,</cfif></cfoutput>]
					}	
			</cfcase>
			<cfcase value="volumeByState">
			<cfquery datasource="paintsquare" name="qAwardVolumnByState">
				select sum(value) as total, state
				from (select sum(amount)/count(bidid) as value, state
				FROM [paintsquare].[dbo].[pbt_market_kpi_total_dollars_tagged]
				where paintpublishdate >= '#bDate# 00:00:00' and paintpublishdate <= '#eDate# 23:59:59'
				--and [Sub Categories] like '%Bridges and Tunnels%'
				group by bidid, paintpublishdate, amount,state) as tbl
				Group By state
				order by state																				 
			</cfquery>	
				{
					"foot": [<cfoutput query="qAwardVolumnByState">"#state#"<cfif currentrow neq qAwardVolumnByState.recordcount>,</cfif></cfoutput>],
					"items": [<cfoutput query="qAwardVolumnByState">#numberformat(total,'00')#<cfif currentrow neq qAwardVolumnByState.recordcount>,</cfif></cfoutput>]
				}	
		</cfcase>
		</cfswitch>			
	</cfcase>
	<cfcase value="mpat">
		<cfswitch expression="#url.sub#">
			<cfcase value="volumeByMonth">
				<cfquery datasource="paintsquare" name="qTotalPerQuarterPerMonth" result="r1">
					--total dollars per month
					select sum(mth1.value) as total, #DateFormat(month1, "m")# as mth, '#DateFormat(month1, "mmm")# #DateFormat(month1, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' 
				and [Sub Categories] like '%Water Tanks%'
					group by bidid, paintpublishdate, amount) as mth1

					union 

					select sum(mth1.value) as total, #DateFormat(month2, "m")# as mth, '#DateFormat(month2, "mmm")# #DateFormat(month2, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and [Sub Categories] like '%Water Tanks%'
					group by bidid, paintpublishdate, amount) as mth1

					union

					select sum(mth1.value) as total, #DateFormat(month3, "m")# as mth, '#DateFormat(month3, "mmm")# #DateFormat(month3, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month3FirstDay# 00:00:00' and paintpublishdate <= '#month3LastDay# 23:59:59' 
				and [Sub Categories] like '%Water Tanks%'
					group by bidid, paintpublishdate, amount) as mth1

					order by mth
				</cfquery>
					{
						"foot": [<cfoutput query="qTotalPerQuarterPerMonth">"#mthname#"<cfif currentrow neq qTotalPerQuarterPerMonth.recordcount>,</cfif></cfoutput>],
						"items": [<cfoutput query="qTotalPerQuarterPerMonth">#total#<cfif currentrow neq qTotalPerQuarterPerMonth.recordcount>,</cfif></cfoutput>]
					}
			</cfcase>
			<cfcase value="valueByMonth">
				<cfquery datasource="paintsquare" name="qAvgContractValuePerMonth" result="r2">
					select sum(mth1.value) as total, #DateFormat(month1, "m")# as mth, '#DateFormat(month1, "mmm")# #DateFormat(month1, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59'
					and [Sub Categories] like '%Water Tanks%' ) as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' 
				and [Sub Categories] like '%Water Tanks%'
					group by bidid, paintpublishdate, amount) as mth1

					union 

					select sum(mth1.value) as total, #DateFormat(month2, "m")# as mth, '#DateFormat(month2, "mmm")# #DateFormat(month2, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and [Sub Categories] like '%Water Tanks%') as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and [Sub Categories] like '%Water Tanks%'
					group by bidid, paintpublishdate, amount) as mth1

					union

					select sum(mth1.value) as total, #DateFormat(month3, "m")# as mth, '#DateFormat(month3, "mmm")# #DateFormat(month3, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and [Sub Categories] like '%Water Tanks%') as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month3FirstDay# 00:00:00' and paintpublishdate <= '#month3LastDay# 23:59:59' 
				and [Sub Categories] like '%Water Tanks%'
					group by bidid, paintpublishdate, amount) as mth1

					order by mth
				</cfquery>	

					{
						"foot": [<cfoutput query="qAvgContractValuePerMonth">"#mthname#"<cfif currentrow neq qAvgContractValuePerMonth.recordcount>,</cfif></cfoutput>],
						"items": [<cfoutput query="qAvgContractValuePerMonth">#numberformat(total/bidcount,'00')#<cfif currentrow neq qAvgContractValuePerMonth.recordcount>,</cfif></cfoutput>]
					}		
			</cfcase>
			<cfcase value="volumeByState">
					<cfquery datasource="paintsquare" name="qAwardVolumnByState">
						select sum(value) as total, state
						from (select sum(amount)/count(bidid) as value, state
						FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
						where paintpublishdate >= '#url.bDate# 00:00:00' and paintpublishdate <= '#url.eDate# 23:59:59'
						and [Sub Categories] like '%Water Tanks%'
						group by bidid, paintpublishdate, amount,state) as tbl
						Group By state
						order by state																				 
					</cfquery>	
				{
					"foot": [<cfoutput query="qAwardVolumnByState">"#state#"<cfif currentrow neq qAwardVolumnByState.recordcount>,</cfif></cfoutput>],
					"items": [<cfoutput query="qAwardVolumnByState">#numberformat(total,'00')#<cfif currentrow neq qAwardVolumnByState.recordcount>,</cfif></cfoutput>]
				}	
			</cfcase>
		</cfswitch>			
	</cfcase>
	<cfcase value="mpaw">
		<cfswitch expression="#url.sub#">
			<cfcase value="volumeByMonth">
				<cfquery datasource="paintsquare" name="qTotalPerQuarterPerMonth" result="r1">
					--total dollars per month
					select sum(mth1.value) as total, #DateFormat(month1, "m")# as mth, '#DateFormat(month1, "mmm")# #DateFormat(month1, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' 
				and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')
					group by bidid, paintpublishdate, amount) as mth1

					union 

					select sum(mth1.value) as total, #DateFormat(month2, "m")# as mth, '#DateFormat(month2, "mmm")# #DateFormat(month2, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')
					group by bidid, paintpublishdate, amount) as mth1

					union

					select sum(mth1.value) as total, #DateFormat(month3, "m")# as mth, '#DateFormat(month3, "mmm")# #DateFormat(month3, "yyyy")#' as mthname
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month3FirstDay# 00:00:00' and paintpublishdate <= '#month3LastDay# 23:59:59' 
				and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')
					group by bidid, paintpublishdate, amount) as mth1

					order by mth
				</cfquery>	
				{
					"foot": [<cfoutput query="qTotalPerQuarterPerMonth">"#mthname#"<cfif currentrow neq qTotalPerQuarterPerMonth.recordcount>,</cfif></cfoutput>],
					"items": [<cfoutput query="qTotalPerQuarterPerMonth">#total#<cfif currentrow neq qTotalPerQuarterPerMonth.recordcount>,</cfif></cfoutput>]
				}		
			</cfcase>
			<cfcase value="valueByMonth">
				<cfquery datasource="paintsquare" name="qAvgContractValuePerMonth" result="r2">
					select sum(mth1.value) as total, #DateFormat(month1, "m")# as mth, '#DateFormat(month1, "mmm")# #DateFormat(month1, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59'
					and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%') ) as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' 
				and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')
					group by bidid, paintpublishdate, amount) as mth1

					union 

					select sum(mth1.value) as total, #DateFormat(month2, "m")# as mth, '#DateFormat(month2, "mmm")# #DateFormat(month2, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')) as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')
					group by bidid, paintpublishdate, amount) as mth1

					union

					select sum(mth1.value) as total, #DateFormat(month3, "m")# as mth, '#DateFormat(month3, "mmm")# #DateFormat(month3, "yyyy")#' as mthname, (select count(bidid)
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')) as bidcount
					from (select sum(amount)/count(bidid) as value
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#month3FirstDay# 00:00:00' and paintpublishdate <= '#month3LastDay# 23:59:59' 
				and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')
					group by bidid, paintpublishdate, amount) as mth1

					order by mth
				</cfquery>	
				{
					"foot": [<cfoutput query="qAvgContractValuePerMonth">"#mthname#"<cfif currentrow neq qAvgContractValuePerMonth.recordcount>,</cfif></cfoutput>],
					"items": [<cfoutput query="qAvgContractValuePerMonth">#numberformat(total/bidcount,'00')#<cfif currentrow neq qAvgContractValuePerMonth.recordcount>,</cfif></cfoutput>]
				}	
			</cfcase>
			<cfcase value="volumeByState">
				<cfquery datasource="paintsquare" name="qAwardVolumnByState">
					select sum(value) as total, state
					from (select sum(amount)/count(bidid) as value, state
					FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
					where paintpublishdate >= '#url.bDate# 00:00:00' and paintpublishdate <= '#url.eDate# 23:59:59'
					and ([Sub Categories] like '%Water/Wastewater%' OR [Sub Categories] like '%Communication%')
					group by bidid, paintpublishdate, amount,state) as tbl
					Group By state
					order by state																				 
				</cfquery>	
				{
					"foot": [<cfoutput query="qAwardVolumnByState">"#state#"<cfif currentrow neq qAwardVolumnByState.recordcount>,</cfif></cfoutput>],
					"items": [<cfoutput query="qAwardVolumnByState">#numberformat(total,'00')#<cfif currentrow neq qAwardVolumnByState.recordcount>,</cfif></cfoutput>]
				}	
			</cfcase>
		</cfswitch>
	</cfcase>
	<cfcase value="mpa">
		<cfswitch expression="#url.sub#">
			<cfcase value="volumeByMonth">
			<cfquery datasource="paintsquare" name="qTotalPerQuarterPerMonth" result="r1">
				--total dollars per month
				select sum(mth1.value) as total, #DateFormat(month1, "m")# as mth, '#DateFormat(month1, "mmm")# #DateFormat(month1, "yyyy")#' as mthname
				from (select sum(amount)/count(bidid) as value
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' 
				group by bidid, paintpublishdate, amount) as mth1

				union 

				select sum(mth1.value) as total, #DateFormat(month2, "m")# as mth, '#DateFormat(month2, "mmm")# #DateFormat(month2, "yyyy")#' as mthname
				from (select sum(amount)/count(bidid) as value
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				group by bidid, paintpublishdate, amount) as mth1

				union

				select sum(mth1.value) as total, #DateFormat(month3, "m")# as mth, '#DateFormat(month3, "mmm")# #DateFormat(month3, "yyyy")#' as mthname
				from (select sum(amount)/count(bidid) as value
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month3FirstDay# 00:00:00' and paintpublishdate <= '#month3LastDay# 23:59:59' 
				group by bidid, paintpublishdate, amount) as mth1

				order by mth
			</cfquery>
				{
					"foot": [<cfoutput query="qTotalPerQuarterPerMonth">"#mthname#"<cfif currentrow neq qTotalPerQuarterPerMonth.recordcount>,</cfif></cfoutput>],
					"items": [<cfoutput query="qTotalPerQuarterPerMonth">#total#<cfif currentrow neq qTotalPerQuarterPerMonth.recordcount>,</cfif></cfoutput>]
				}
			</cfcase>
			<cfcase value="valueByMonth">
			<cfquery datasource="paintsquare" name="qAvgContractValuePerMonth" result="r2">
				select sum(mth1.value) as total, #DateFormat(month1, "m")# as mth, '#DateFormat(month1, "mmm")# #DateFormat(month1, "yyyy")#' as mthname, (select count(bidid)
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' ) as bidcount
				from (select sum(amount)/count(bidid) as value
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month1FirstDay# 00:00:00' and paintpublishdate <= '#month1LastDay# 23:59:59' 
				group by bidid, paintpublishdate, amount) as mth1

				union 

				select sum(mth1.value) as total, #DateFormat(month2, "m")# as mth, '#DateFormat(month2, "mmm")# #DateFormat(month2, "yyyy")#' as mthname, (select count(bidid)
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' ) as bidcount
				from (select sum(amount)/count(bidid) as value
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' 
				group by bidid, paintpublishdate, amount) as mth1

				union

				select sum(mth1.value) as total, #DateFormat(month3, "m")# as mth, '#DateFormat(month3, "mmm")# #DateFormat(month3, "yyyy")#' as mthname, (select count(bidid)
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month2FirstDay# 00:00:00' and paintpublishdate <= '#month2LastDay# 23:59:59' ) as bidcount
				from (select sum(amount)/count(bidid) as value
				FROM [paintsquare].[dbo].[pbt_market_total_dollars_unique]
				where paintpublishdate >= '#month3FirstDay# 00:00:00' and paintpublishdate <= '#month3LastDay# 23:59:59' 
				group by bidid, paintpublishdate, amount) as mth1

				order by mth
			</cfquery>	
				{
					"foot": [<cfoutput query="qAvgContractValuePerMonth">"#mthname#"<cfif currentrow neq qAvgContractValuePerMonth.recordcount>,</cfif></cfoutput>],
					"items": [<cfoutput query="qAvgContractValuePerMonth">#numberformat(total/bidcount,'00')#<cfif currentrow neq qAvgContractValuePerMonth.recordcount>,</cfif></cfoutput>]
				}	
			</cfcase>
			<cfcase value="volumeByState">
				<cfquery datasource="paintsquare" name="qAwardVolumnByState">
					select sum(value) as total, state
					from (select sum(amount)/count(bidid) as value, state
					FROM [paintsquare].[dbo].[pbt_market_kpi_total_dollars_tagged]
					where paintpublishdate >= '#bDate# 00:00:00' and paintpublishdate <= '#eDate# 23:59:59'
					group by bidid, paintpublishdate, amount,state) as tbl
					Group By state
					order by state																				 
				</cfquery>	
				{
					"foot": [<cfoutput query="qAwardVolumnByState">"#state#"<cfif currentrow neq qAwardVolumnByState.recordcount>,</cfif></cfoutput>],
					"items": [<cfoutput query="qAwardVolumnByState">#numberformat(total,'00')#<cfif currentrow neq qAwardVolumnByState.recordcount>,</cfif></cfoutput>]
				}	
			</cfcase>
		</cfswitch>				  
	</cfcase>
</cfswitch>
