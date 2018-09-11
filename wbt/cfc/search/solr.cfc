<cfcomponent>
	<cffunction name="doesPdfExist" access="public" returntype="String">
		<cfargument name="bidid" type="numeric" required="yes">
		<cftry>
		<cfquery dbtype="query" name="qRslts">
			select pdf_exists
			from session.qresults
			where bidid = #arguments.bidid#
		</cfquery>	
		<cfset myResult=yesnoformat(qRslts.pdf_exists)>
		<cfcatch><cfset myResult='no'/></cfcatch></cftry>	
		<cfreturn myResult>
	</cffunction>
			
	<cffunction name="getShard" access="public" returntype="string">
		<cfargument name="bidid" type="numeric" required="yes">
		<cftry>
		<cfquery dbtype="query" name="qRslts">
			select shard
			from session.qresults
			where bidid = #arguments.bidid#
		</cfquery>	
		<cfset myResult=qRslts.shard>
		<cfcatch><cfset myResult='bad'/></cfcatch></cftry>	
		<cfreturn myResult>
	</cffunction>
			
			
	<cffunction name="getOnviarefnum" access="public" returntype="string">
		<cfargument name="bidid" type="numeric" required="yes">
		<cftry>
		<cfquery dbtype="query" name="qRslts" maxrows="1">
			select onviarefnum
			from session.qresults
			where bidid = #arguments.bidid#
		</cfquery>	
		<cfset myResult=qRslts.onviarefnum>
		<cfcatch><cfset myResult='bad'/></cfcatch></cftry>	
		<cfreturn myResult>
	</cffunction>
</cfcomponent>