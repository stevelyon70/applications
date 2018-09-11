<cfparam name="url.kw" default='project'>
<cfset getInfo = application.searchObj.getRefPdfasQ(url.bidid) />
<cfdump var="#getInfo.pdf_files#" expand="yes">
<!---<cfdump var="#session.qresults#" expand="no">

<cfoutput>#getInfo.onviarefnum#</cfoutput>
<cfabort>--->
<!---<cfset getShard = application.searchObj.getShard(url.bidid) />--->

<cfhttp result="result" method="GET" charset="utf-8" url='http://ec2-52-35-107-213.us-west-2.compute.amazonaws.com:8983/solr/pdf_repository/select'>
    <cfhttpparam name="q" type="formfield" value="*:*">
    <cfhttpparam name="fq" type="formfield" value="ref:#getInfo.onviarefnum#">
    <cfhttpparam name="df" type="formfield" value="pdf">
    <cfhttpparam name="hl" type="formfield" value='on'>
    <cfhttpparam name="hl.q" type="formfield" value='#url.kw#'>
    <cfhttpparam name="hl.fl" type="formfield" value='pdf'>
    <!---<cfhttpparam name="hl.usePhraseHighlighter" type="formfield" value='on'>--->
    <cfhttpparam name="hl.snippets" type="formfield" value='10'>
    <cfhttpparam name="hl.fragsize" type="formfield" value='500'>
    <cfhttpparam name="hl.simple.pre" type="formfield" value='<span class="highlite">'>
    <cfhttpparam name="hl.simple.post" type="formfield" value='</span>'>
    <!---<cfhttpparam name="fl" type="formfield" value='id'>--->
</cfhttp>

<cfset bids = deserializeJSON(result.filecontent)>
<!---<cfdump var = "#bids#">
<cfdump var = "#bids.highlighting#">--->


	<cfloop collection="#bids.highlighting#" item="key">	
		<cfif NOT structIsEmpty(bids.highlighting[key])>
			<cfset snippets = true>
			<div>
				<table class="table table-striped">		
					<tr><td>DOCUMENT: <cfoutput>#listlast(listfirst(key,"|"),"/")#</cfoutput></td></tr>
					
					<cfloop array="#bids.highlighting[key].pdf#" index="snip">
						<tr>
							<td>
								<p>...<cfoutput>#snip#</cfoutput>...</p>
							</td>
						</tr>		
					</cfloop>
					
				</table>
			</div>	
		</cfif>	
	</cfloop>




<cfabort>

	<!---<cfdump var="#bids#"/>--->
<!---<cfset recs = #arraylen(bids.highlighting['36400312/18340358.pdf|2018-06-01T09:13:30Z'].pdf)#>--->
	
	<cfloop list="#getInfo.pdf_files#" index="r">
		<cfif isDefined(bids.highlighting[r]) AND NOT structIsEmpty(bids.highlighting[r])>
			<tr><td>DOCUMENT: <cfoutput>#listlast(listfirst(r,"|"),"/")#</cfoutput></td></tr>
			<cfset recs = #arraylen(bids.highlighting[r].pdf)#>
			<cfloop from="1" to="#recs#" index="f">
				<tr>
					<td>
						<p>...<cfoutput>#bids.highlighting[r].pdf[f]#</cfoutput>...</p>
					</td>
				</tr>		
			</cfloop>
		</cfif>
	</cfloop>	

<cfabort>
<cfdump var = "#bids.highlighting['36400312/18340358.pdf|2018-06-01T09:13:30Z'].pdf#"><br>
<cfdump var = "#bids.highlighting['36400312/18340360.pdf|2018-06-01T09:13:44Z'].pdf#"><br>
<cfdump var = "#bids.highlighting['36400312/18340357.pdf|2018-06-01T09:13:26Z'].pdf#"><br>
<cfdump var = "#bids.highlighting['36400312/18340359.pdf|2018-06-01T09:13:42Z'].pdf#"><br>


<cfdump var = #bids#>
36400312/18340358.pdf|2018-06-01T09:13:30Z
36400312/18340360.pdf|2018-06-01T09:13:44Z
36400312/18340357.pdf|2018-06-01T09:13:26Z
36400312/18340359.pdf|2018-06-01T09:13:42Z--->