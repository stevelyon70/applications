<cfcomponent>
	<cffunction name="tagDisplay" access="public" returntype="String">
		<cfargument name="tagid" type="numeric" required="yes">
		<cfargument name="tag_list" type="string" required="yes" default="">
		
		<!--- Tags which are to be hidden for this site --->
		<cfset hidden_list= "12,677"> 
		<cfset myResult= ""> 
		<cfif arguments.tag_list neq "">
			<cfset hidden_list= "#arguments.tag_list#"> 
		</cfif>
		<cftry>		
			<!---<cfif listfind(hidden_list,arguments.tagid)>
				<cfset myResult= "hidden">
			</cfif>--->
		<cfcatch><cfset myResult= ""/></cfcatch>
		</cftry>
			
		<cfreturn myResult>
	</cffunction>
</cfcomponent>