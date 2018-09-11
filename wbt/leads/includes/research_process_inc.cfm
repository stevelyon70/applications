
<cfset bidID = #form.bidID#>

<cfset sitename = "WaterBidTracker">
<cfset display_name= "Water BidTracker">
<cfset recip_list="jbirch@technologypub.com;bnaccarelli@technologypub.com">


<cflock timeout="15" name="send">

	<cfset todate = CREATEODBCDATE(NOW())>
	<cfset todate = dateformat(todate, "mmddyyy")>
	<cfset variables.filetoSend = "#sitename#_lead_detail_#bidID##userID##todate#.pdf">

	<cfdocument format="pdf" filename="D:\gateway_attachments\#variables.filetoSend#" encryption="128-BIT" permissions="ALLOWPRINTING" pagetype="LETTER" overwrite="YES" >
		<!---<img src="../../images/PaintBidTracker_PaintcanLogo.png" alt="Paint BidTracker" border="0"> --->
		<p class="BigBold" style="margin-top: 18; margin-bottom: 12">#display_name# Project Detail</p>

			
			<cfoutput>#session.bidDetail[bidid]#</cfoutput>
			

		<p align="center">
		<span style="font-family: arial, Arial, Helvetica;  font-size: 6pt; color:red; font-weight:bold">
		Distribution of <cfoutput>#display_name#</cfoutput> information to unauthorized users is strictly prohibited and will result in the permanent cancellation of your account.
		</span>
		</p>
	</cfdocument>

	<cfmail 
	to="#recip_list#" 
	from="admin@paintbidtracker.com"	
	subject="Requested Additional Research - #display_name#"
	bcc="slyon@technologypub.com; rmahathey@technologypub.com"
	type="html"
	>
		<cfmailparam file="D:\gateway_attachments\#variables.filetoSend#">
		<cfoutput>
		The following subscriber has requested additional research on BidID-#bidID#:<br><br>

		#form.emailname#<br>
		#form.email#<br>
		#form.company#<br>
		#form.phone#<br><br>

		<cfif isdefined("comments") and comments NEQ "">
		Additional Comments: #form.comments#
		</cfif>
		<br>
		To review, open the attached PDF using Adobe Acrobat version 5.0 or greater. 
		<br>
		#display_name#<br>
		http://www.#sitename#.com
		</cfoutput>
	</cfmail>

 </cflock>