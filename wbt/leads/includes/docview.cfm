<cfset snippets = false>
<cfset getShard = application.searchObj.getShard(url.bidid) />

<cfhttp result="result" method="GET" charset="utf-8" url='#getShard#/tpc'>
    <cfhttpparam name="q" type="formfield" value="bidID:#url.bidid#">  
    <cfhttpparam name="rows" type="formfield" value='1'>
    <cfhttpparam name="fl" type="formfield" value='id,bidID,pdf'>
</cfhttp>

<cfset bids = deserializeJSON(result.filecontent)>
<cfset recs = #bids.response.docs#>

<cfset url.kw= #replace(url.kw, '\', '', "all")#>
<div>
	<form name="kwmodal" id="kwmodal" action="javascript:void(0);">
		<table>
			<tr>
				<td><input type="text" name="kw" id="kw" value='<cfoutput>#url.kw#</cfoutput>'> &nbsp; <input name="kwsearch" id="kwsearch" type="submit" value="Search Bid Document" class="btn btn-primary btn-sm" data-bidid="<cfoutput>#url.bidid#</cfoutput>"></td>
			</tr>
		</table>
	</form>
</div>

<cfset url.kw= #replace(url.kw, '"', '', "all")#>
<cfset kwlen = #len(url.kw)#>

<cfsavecontent variable="thisSnippets">
<cfloop from="1" to="#arraylen(bids.response.docs[1].pdf)#" index="r"><!------>
	<cfif len(bids.response.docs[1].pdf[r]) GT 0>
		<!---|<cfoutput>#len(bids.response.docs[1].pdf[r])#,</cfoutput>--->
		<cfset position_list = "">
		<!--- Determine total number of instances of keyword in current document text --->
		<cfset variables.string = "#bids.response.docs[1].pdf[r]#" />
		<cfset variables.substring = "#url.kw#" />

		<cfif #Len(string)# eq #Len(Replace(string,substring,'','all'))#>
			<cfset occurrences = 1>
		<cfelse>
			<cfset occurrences = ( Len(string) - Len(Replace(string,substring,'','all'))) / Len(substring) >
		</cfif>
		<!---<cfdump var="(#occurrences#)">	--->
		
		<cfif occurrences GT 0>
			<cfif occurrences GT 1><cfset occurrences = occurrences - 1></cfif>
			
			<div>
				<table class="table table-striped">

					<!--- Search for positions of instances --->
					<cfloop from="1" to="#occurrences#" index="p">
						<cfif p EQ 1>
							<cfset currentInstance = refindNoCase(kw, bids.response.docs[1].pdf[r]) />
						<cfelse>						
							<cfif refindNoCase(kw, bids.response.docs[1].pdf[r], currentInstance+kwlen)>
								<cfset currentInstance = refindNoCase(kw, bids.response.docs[1].pdf[r], currentInstance+kwlen)>
							</cfif>				
						</cfif>	
						<cfset position_list = #listappend(position_list,currentInstance)#>
					</cfloop>
					<!---<cfdump var="[#position_list#]">--->	
					<cfset c= 1>
					<cfset old_pos = 0>
					
					<cfloop list="#position_list#" index="pos">
						<cfif pos GT 0>
							<cfif pos mod 200 eq 0><cfset pos = 201></cfif>
							<cfif c EQ 1 OR (pos - old_pos) GT 500>		
								<cfset context = mid(bids.response.docs[1].pdf[r], pos-200, 650) />
								<cfset lighted = replaceNoCase(context, kw, '<span class="highlite">#kw#</span>', "all")> 
								<tr>
									<td>
										<p>...<cfoutput>#lighted#</cfoutput>...</p>
									</td>
								</tr>						
								<cfif c GT 10><cfbreak><cfelse><cfset c=c+1></cfif><!--- 10 snippets per PDF --->
								<cfset old_pos = pos>	
								<cfset snippets = true>	
							</cfif>
						</cfif>
					</cfloop>	
									
				</table>
			</div>		

		</cfif>
	</cfif>
</cfloop>
</cfsavecontent>
<!---<cfoutput>#len(trim(thisSnippets))#</cfoutput>---->
<cfif snippets>
	<cfoutput>#thisSnippets#</cfoutput>
<cfelse>
	<div><p><br>No results in document, see <a href="../leads/?bidid=<cfoutput>#url.bidid#&keywords=#url.kw#</cfoutput>">project detail</a></p></div>
</cfif>	

<style>
	.highlite{
		background:yellow;
	}	
</style>
<script>
		$("#kwsearch").click(function(e){	
		e.preventDefault();
		var bidID = $(this).attr('data-bidid');
		var kw = $('#kw').val();
		$(".dv-body").html("Content loading please wait...  <img src='../assets/images/spinner.svg'>");
		$(".dv-body").load('../leads/includes/docview.cfm?bidid=' + bidID + "&kw="+ encodeURIComponent(kw));
	});	
</script>




