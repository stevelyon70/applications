	
	<p class="footGap">&nbsp;</p>
	<cfoutput>
	<div class="footer clearfix"  >
		<div class="footer-wrap">
			<div class="footer-content">
					<div style="padding-left:10px;">
					<a  href="#request.rootpath#dmz/?action=faq">FAQ</a>
					<span class="linkSeparator"> | </span>
					<a href="mailto:feedback@waterbidtracker.com">Feedback</a>
					<span class="linkSeparator"> | </span>
					<a href="http://www.waterbidtracker.com/info/" target="_blank">Contact Us</a>
					<span class="linkSeparator"> | </span>
					<a  href="/dmz/?action=terms">Terms of Use</a>
					<span class="linkSeparator"> | </span>
					<a href="/dmz/?action=privacy">Privacy Policy</a>
					</div>
				© Copyright 2018<cfif Year(now()) GT 2018>-#dateformat(now(),"yyyy")#</cfif>, Technology Publishing, Co., All rights reserved 
			</div>
		</div>
		<div class="footer-items">
			<span class="go-top"><i class="clip-chevron-up"></i></span>
		</div>
	</div>
	</cfoutput>