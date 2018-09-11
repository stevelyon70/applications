<cfswitch expression = "#cgi.server_name#">
    <cfcase value = "app.paintbidtracker.com">
	<img src="https://app.paintbidtracker.com/assets/images/PBT_Logo_WebHeader_Home_DoubleSize.png">
    </cfcase>     
    <cfcase value = "app.waterbidtracker.com">
        <img src="https://app.waterbidtracker.com/assets/images/WBT_Logo_WebHeader_Home_DoubleSize.png">
    </cfcase>        
</cfswitch>