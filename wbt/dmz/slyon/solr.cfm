<cfparam name="url.kw" default= "paint" /><cfset bidlist ="">
<!---<cfdump var="#session.qresults#" expand="no">
<cfset url.kw= #REreplace(url.kw, '"', '\"', "all")#>--->
<cfdump var="#url.kw#">4907217,4907217,4892236,4891536,4907170,4891101,4908813,4890513,4891100



<cfhttp result="result" method="GET" charset="utf-8" url='http://ec2-52-35-107-213.us-west-2.compute.amazonaws.com:8983/solr/pbt_current_bids/tpc'><!---?q=%22NACE+CIP%22--->
    
    <cfif isDefined("url.bidid")>
    <cfhttpparam name="q" type="formfield" value='bidID:#url.bidid#'>
    <cfelse>
    <cfhttpparam name="q" type="formfield" value='#url.kw#'>
    </cfif>
   <!--- <cfhttpparam name="fq" type="formfield" value='description:bridge'>--->
    <!---
    <cfhttpparam name="hl" type="formfield" value='on'>
    <cfhttpparam name="hl.fl" type="formfield" value='pdf'>
    <cfhttpparam name="hl.q" type="formfield" value='bridge'>
    <cfhttpparam name="hl.usePhraseHighlighter" type="formfield" value='on'>
    <cfhttpparam name="hl.snippets" type="formfield" value='20'>
    <cfhttpparam name="hl.fragsize" type="formfield" value='500'>
    <cfhttpparam name="hl.simple.pre" type="formfield" value='<span class="highlite">'>
    <cfhttpparam name="hl.simple.post" type="formfield" value='</span>'>
    --->
   <!---<cfhttpparam name="shards" type="formfield" value="http://ec2-52-35-107-213.us-west-2.compute.amazonaws.com:8983/solr/pbt_current_bids,http://ec2-52-35-107-213.us-west-2.compute.amazonaws.com:8983/solr/pbt_lowbids">--->

    <!---<cfhttpparam name="rows" type="formfield" value='200'>---><cfhttpparam name="fl" type="formfield" value='bidID, description,onviarefnum,pdf_exists:exists(pdf), pdf_ids,pdf'> 
    <!---<cfhttpparam name="fl" type="formfield" value='id, onviarefnum,bidID, description,pdf_exists:exists(pdf),shard:[shard],pdf'>--->
</cfhttp>
<cfset bids = deserializeJSON(result.filecontent)>				
<cfset recs = #arraylen(bids.response.docs)#>
				<cfloop from="1" to="#recs#" index="r">
					<cfset bidlist = listappend(bidlist,bids.response.docs[r].bidID)/>
				</cfloop>
<cfdump var="#bidlist#">
<!--- bidID,pdf_exists:exists(pdf),CompanyName, _version_, city, county, description, id, key, last_modified, onviarefnum, owner, pdf, projectname, tag, zipcode,shard:[shard] --->
<!---<cfdump var="#result.filecontent#"><cfabort>--->


<!---cfset recs = #bids.response.docs#--->
KEYWORD: <cfoutput>#url.kw#</cfoutput><br><br>	
<cfdump var=#bids.response.numFound#>
<!---<cfdump var = "#bids.highlighting#">--->
<cfdump var=#bids#>
	<cfabort>
<!---<cfdump var = "#session.qresults#">--->
<!---<cfset hasPDf = application.searchObj.doesPdfExist(23323) />
<cfdump var = "#yesnoformat(hasPDf)#">--->
<!---
<cfset qresults = QueryNew( "bidID, pdf_exists, shard", "INTEGER, VARCHAR, VARCHAR" ) />
	<cfoutput>#arraylen(recs)#</cfoutput>
	<cfloop from="1" to="#arraylen(recs)#" index="_i">
		<cfoutput>#recs[_i].bidID#</cfoutput>
		<cfset QueryAddRow(qresults,1) />
		<cfset QuerySetCell(qresults, "bidID", recs[_i].bidID, _i) />
		<cfset QuerySetCell(qresults, "pdf_exists", recs[_i].pdf_exists, _i) />
		<cfset QuerySetCell(qresults, "shard", recs[_i].shard, _i) />
	</cfloop>
<cfdump var = "#qresults#"><cfabort>--->

<!------><cfabort>
<cfloop from="1" to="#recs#" index="r">
	<cfoutput>#bids.response.docs[r].bidID#</cfoutput>
</cfloop>

<cfdump var = "#bids.highlighting#">
<!---<cfdump var = "#bids.response.docs[1].companyname#">

<cfoutput>#bids.response.docs[2].onviarefnum[1]#</cfoutput>--->

<cfdump var = "#bids.response.docs#"><cfabort><!------>


<cfscript>
		/*
		I highlight words in a string that are found in a keyword list. Useful for search result pages.
		@param str String to be searched
		@param searchterm Comma delimited list of keywords
		*/
		string function highlightKeywords( required string str, required string searchterm ){
		var j = "";
		var matches = "";
		var word = "";
		// loop through keywords
		for( var i=1; i lte ListLen( arguments.searchterm, " " ); i=i+1 ){
		// get current keyword and escape any special regular expression characters
		word = ReReplace( ListGetAt( arguments.searchterm, i, " " ), "\.|\^|\$|\*|\+|\?|\(|\)|\[|\]|\{|\}|\\", "" );
		// return matches for current keyword from string
		matches = ReMatchNoCase( word, arguments.str );
		// remove duplicate matches (case sensitive)
		matches = CreateObject( "java", "java.util.HashSet" ).init( matches ).toArray();
		// loop through matches
		for( j=1; j <= ArrayLen( matches ); j=j+1 ){
		// where match exists in string highlight it
		arguments.str = Replace( arguments.str, matches[ j ], "<span style='background:yellow;'>#matches[ j ]#</span>", "all" );
		}
		}
		return arguments.str;
		}
	</cfscript>

<cfoutput>#highlightKeywords( bids.response.docs[1].pdf[1], "sidewalk" )#</cfoutput>


<!--- <cfif !IsJSON(result.filecontent)>
    <h3>The URL you requested does not provide valid JSON</h3>


<cfelse>
    <cfset bids = DeserializeJSON(result.filecontent)>
   <!--- <cfdump var=#bids# >--->
		<cfif structKeyExists( bids.response, 'docs' ) AND isArray(bids.response.docs)>
        <cfoutput>
         <cfloop index="i" from="1" to="#arraylen(bids.response.docs)#">#i#
            <h3>Company: #bids.response.docs[i].companyname[1]#</h3>
            <h4>Key: #bids.response.docs[i].key[1]#</h4>
        </cfloop>
        </cfoutput>
		</cfif>
</cfif>
--->