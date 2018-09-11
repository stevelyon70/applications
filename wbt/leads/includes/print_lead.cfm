<cfif isDefined("url.bidid")>
<cfdocument localUrl="yes" format="pdf">
	<!--- Header --->
	<cfdocumentitem type="header">
		<img src="../../assets/images/WBT_Logo_WebHeader_Home_DoubleSize.png" width="300" alt="Water BidTracker" border="0"> Water BidTracker Lead Details
	</cfdocumentitem>
		
	<cfoutput>#session.bidDetail[url.bidid]#</cfoutput>
		
	<!--- Footer --->
	<cfdocumentitem type="footer">
		<p align="center">
			Distribution of Water BidTracker information to unauthorized users is strictly prohibited and will result in the permanent cancellation of your account.
		</p>
	</cfdocumentitem>
</cfdocument>
<cfelse>
UNABLE TO PRINT
</cfif>