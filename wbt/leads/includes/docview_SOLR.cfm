<cfset snippets = false>
<!---<cfset url.kw= #replace(url.kw, '"', '', "all")#>--->
<cfset getOnvia = application.searchObj.getOnviarefnum(url.bidid) />

<cfhttp result="result" method="GET" charset="utf-8" url='http://ec2-52-35-107-213.us-west-2.compute.amazonaws.com:8983/solr/pdf_repository/select'>
    <cfhttpparam name="q" type="formfield" value="*:*">
    <cfhttpparam name="fq" type="formfield" value="ref:#getOnvia#">
    <cfhttpparam name="df" type="formfield" value="pdf">
    <cfhttpparam name="hl" type="formfield" value='on'>
    <cfhttpparam name="hl.q" type="formfield" value='"#url.kw#"'>
    <cfhttpparam name="hl.fl" type="formfield" value='pdf'>
    <!---<cfhttpparam name="hl.usePhraseHighlighter" type="formfield" value='on'>--->
    <cfhttpparam name="hl.snippets" type="formfield" value='10'>
    <cfhttpparam name="hl.fragsize" type="formfield" value='500'>
    <cfhttpparam name="hl.simple.pre" type="formfield" value='<span class="highlite">'>
    <cfhttpparam name="hl.simple.post" type="formfield" value='</span>'>
</cfhttp>

<cfset bids = deserializeJSON(result.filecontent)>

<cfif isStruct(bids)>

	<!---<cfdump var = #bids#><cfabort>--->
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
	
	<cfloop collection="#bids.highlighting#" item="key">	
		<cfif NOT structIsEmpty(bids.highlighting[key])>
			<cfset snippets = true>
			<div>
				<table class="table table-striped" style="border-right:solid 1px black;border-left:solid 1px black;border-bottom:solid 1px black;">		
					<tr><td style="background-color:#E5E4D7;border-top:solid 1px black;"><b>DOCUMENT:</b> <cfoutput>#listlast(listfirst(key,"|"),"/")#</cfoutput></td></tr>
					
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

	<cfif NOT snippets>
		<p><br>No results in document, see <a href="../leads/?bidid=<cfoutput>#url.bidid#&keywords=#url.kw#</cfoutput>">project detail</a></p></div>
	</cfif>
	
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
		$(".dv-body").load('../leads/includes/docview_SOLR.cfm?bidid=' + bidID + "&kw="+ encodeURIComponent(kw));
	});	
</script>
