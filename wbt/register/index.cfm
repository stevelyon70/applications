
<cfparam default="" name="url.function" />
<CFSET DATE = #CREATEODBCDATETIME(NOW())#> 
<CFSET BASEDATE = #createodbcdate(now())#>  
<cfinclude template="../template_inc/design/wrapper_top.cfm">
					
			<cftry>
				<cfswitch expression="#url.action#">
					<!---include the signup landing page for profiles--->
						<cfcase value="signup">
							<cfinclude template="includes/signup_inc.cfm">
						</cfcase>
						<cfcase value="forgotpassword">
							<cfinclude template="includes/forgot_password_inc.cfm">
						</cfcase>
						<cfcase value="forgotconfirm">
							<cfinclude template="includes/forgot_password_confirm_inc.cfm">
						</cfcase>

					</cfswitch>
				<cfcatch><cfdump var="#cfcatch#"/></cfcatch>
			</cftry>
		</div>
	</div>
</div>
<cfinclude template="../template_inc/footer_inc.cfm">
<cfinclude template="../template_inc/feedback.cfm">	
<cfinclude template="../template_inc/script_inc.cfm">	
<script>
	jQuery(document).ready(function() {
		Main.init();
	});
</script>
<cfinclude template="../template_inc/design/wrapper_bot.cfm">