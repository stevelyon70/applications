<!---
Terms and Conditions
--->
<cfquery name="getprivacy" datasource="#application.dataSource#" maxrows="1">
	select privacy_text, updatedon
	from privacy_update
	where gateway_id = 15
	order by updateID desc
</cfquery>      

<cfoutput>
<div align="left">
	<!---Begin Heading--->
	<table border="0" cellpadding="5" cellspacing="0" width="100%" bgcolor="ffffff">
		<tr>
			<td width="100%" align="left" valign="top" colspan="3">
				<div align="left">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td align="left" valign="bottom">
								<h1><span style="font-size:16px">Water BidTracker Information</span></h1>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<!---End Heading--->
	<!---Begin Main Area--->
	<table border="0" cellpadding="5" cellspacing="0" width="100%">
		<tr>
			<td valign="top">
		       <table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td>
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="100%" valign="bottom"><p class="header1"> 
										<b>Terms and Conditions</b></a>
									</td>
								</tr>
							</table>
						<hr class="PBTsmall" noshade>
						</td>
					</tr>
					<tr>
						<td width="100%">
							<h2>Visitor Agreement</h2>
							<p>By using the waterbidtracker.com service, you accept its terms. We may change the terms of this agreement from time to time. By continuing to use the service after we post any such changes, you accept this agreement, as modified.</p>
							<p>If you are an owner of intellectual property who believes your intellectual property has been improperly posted or distributed via this web site, please notify us, by e-mail, to <a href="mailto:webmaster@waterbidtracker.com">webmaster@waterbidtracker.com</a>.</p>
							<p>The material that appears on waterbidtracker.com is for informational purposes only. Despite our efforts to provide useful and accurate information, errors may appear from time to time. Before you act on information on waterbidtracker.com, you should confirm any facts that are important to your decision. Technology Publishing is not responsible for, and cannot guarantee the performance of, goods and services provided by our advertisers or others to whose sites we link. A link to another web site does not constitute an endorsement of that site (nor of any product, service, or other material offered on that site) by Technology Publishing.</p>
							<h2>Content of Postings</h2>
							<p>Technology Publishing reserves the right (but assumes no obligation) to delete, move, or edit any postings to the site considered unacceptable or inappropriate for legal or other reasons. Technology Publishing will not, in the ordinary course of business, review private electronic messages that are not addressed to Technology Publishing. However, we will comply with the requirements of the law regarding disclosure of such messages to others, including law enforcement agencies.</p>
							<h2>Intellectual Property</h2>
							<p>Technology Publishing expects that you will not use the service to violate anyone's copyright, trademark, or other intellectual property rights. By submitting material to waterbidtracker.com, you are representing that you are making your submission with the express consent of the owner. Submitting material that is the property of another, without the consent of its owner, is not only a violation of this agreement but may also subject you to legal liability for infringement of copyright, trademark, or other intellectual property rights.</p>
							<p>Although we make waterbidtracker.com publicly accessible, we don't intend to give up our rights, or anyone else's rights, to the materials appearing on the service. The materials available through waterbidtracker.com are the property of Technology Publishing, Southside Holdings, and/or its licensors, and are protected by copyright, trademark, and other intellectual property laws. You are free to display and print for your personal, non-commercial use information you receive through waterbidtracker.com, but you may not otherwise reproduce any of the materials without the prior written consent of the owner. You may not distribute copies of materials found on waterbidtracker.com in any form (including by e-mail or other electronic means) without prior written permission from the owner. <!---Of course, you're free to encourage others to access the information themselves and to tell them how to find it. --->Requests for permission to reproduce or distribute materials found on waterbidtracker.com should be sent to <a href="mailto:webmaster@waterbidtracker.com">webmaster@waterbidtracker.com</a>.</p>
							<h2>Solicitations</h2>
							<p>You agree not to use waterbidtracker.com to advertise or to solicit anyone to buy or sell products or services or to make donations of any kind without our express written approval.</p>
							<h2>Spamming</h2>
							<p>From time to time, users post their e-mail addresses in public posting areas of the site. You agree not to gather these e-mail addresses for purposes of spamming.</p>
							<h2>Links</h2>
							<p>Waterbidtracker.com welcomes links to our service. You are free to establish a hypertext link to this site so long as the link does not state or imply any sponsorship of your site by waterbidtracker.com.&nbsp;
							<h2>Framing</h2>
							<p>Without the prior written permission of Technology Publishing, you may not frame any of the content of waterbidtracker.com or incorporate into another web site or other service any intellectual property of Technology Publishing or any of their licensors. Requests for permission to frame our content may be sent to <a href="mailto:webmaster@waterbidtracker.com">webmaster@waterbidtracker.com</a>.</p>
							<h2>Trademarks</h2>
							<p>You may not use any trademark or service mark appearing on waterbidtracker.com without the prior written consent of the owner of the mark. &quot;Technology Publishing,&quot; &quot;Waterbidtracker.com,&quot; and the Water BidTracker and Technology Publishing logos are trademarks of Technology Publishing.</p>
							<h2>Registration</h2>
							<p>To obtain access to many services on our site, you may be given an opportunity to register with waterbidtracker.com. As part of any such registration process, you will select a user name and a password. You agree that the information you supply during that registration process will be accurate and complete and that you will not register under the name of, nor attempt to enter the service under the name of, another person. Technology Publishing reserves the right to reject or terminate any user name that, in its judgment, it deems offensive. You will be responsible for preserving the confidentiality of your password and will notify waterbidtracker.com of any known or suspected unauthorized use of your account.</p>
							<p>This visitor agreement has been made in and shall be construed in accordance with the laws of the Commonwealth of Pennsylvania. By using this service, you consent to the exclusive jurisdiction of the state and federal courts in Allegheny County, Pennsylvania, in all disputes arising out of or relating to this agreement or this web site. By using waterbidtracker.com, you agree to abide by the terms of this visitor agreement. We hope you enjoy using waterbidtracker.com, and we welcome suggestions for improvements.</p>
							<h2>DISCLAIMER OF WARRANTIES AND LIABILITY</h2>
							<p>Please read this Disclaimer carefully before using waterbidtracker.com</p>
							<p>YOU AGREE THAT YOUR USE OF THIS SERVICE IS AT YOUR SOLE RISK. BECAUSE OF THE NUMBER OF POSSIBLE SOURCES OF INFORMATION AVAILABLE THROUGH THE SERVICE AND THE INHERENT HAZARDS AND UNCERTAINTIES OF ELECTRONIC DISTRIBUTION, THERE MAY BE DELAYS, OMISSIONS, INACCURACIES, OR OTHER PROBLEMS WITH SUCH INFORMATION. IF YOU RELY ON THIS SERVICE OR ANY MATERIAL AVAILABLE THROUGH THIS SERVICE, YOU DO SO AT YOUR OWN RISK. YOU UNDERSTAND THAT YOU ARE SOLELY RESPONSIBLE FOR ANY DAMAGE TO YOUR COMPUTER SYSTEM OR LOSS OF DATA THAT RESULTS FROM ANY MATERIAL AND/OR DATA DOWNLOADED FROM OR OTHERWISE PROVIDED THROUGH WATERBIDTRACKER.COM.</p>
							<p>THIS SERVICE IS PROVIDED TO YOU &quot;AS IS,&quot; &quot;WITH ALL FAULTS,&quot; AND &quot;AS AVAILABLE.&quot; TECHNOLOGY PUBLISHING AND THEIR AFFILIATES, AGENTS, AND LICENSORS CANNOT AND DO NOT WARRANT THE ACCURACY, COMPLETENESS, CURRENTNESS, NONINFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE OF THE INFORMATION AVAILABLE THROUGH THE SERVICE. NOR DO THEY GUARANTEE THAT THE SERVICE WILL BE ERROR-FREE, OR CONTINUOUSLY AVAILABLE, OR THAT THE SERVICE WILL BE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS.</p>
							<p>UNDER NO CIRCUMSTANCES SHALL TECHNOLOGY PUBLISHING OR THEIR AFFILIATES, AGENTS, OR LICENSORS BE LIABLE TO YOU OR ANYONE ELSE FOR ANY DAMAGES ARISING OUT OF USE OF WATERBIDTRACKER.COM, INCLUDING, WITHOUT LIMITATION, LIABILITY FOR CONSEQUENTIAL, SPECIAL, INCIDENTAL, INDIRECT, OR SIMILAR DAMAGES, EVEN IF WE ARE ADVISED BEFOREHAND OF THE POSSIBILITY OF SUCH DAMAGES. (BECAUSE SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF CERTAIN CATEGORIES OF DAMAGES, THE ABOVE LIMITATION MAY NOT APPLY TO YOU. IN SUCH STATES, THE LIABILITY OF TECHNOLOGY PUBLISHING AND THEIR AFFILIATES, AGENTS, AND LICENSORS IS LIMITED TO THE FULLEST EXTENT PERMITTED BY SUCH STATE LAW.) YOU AGREE THAT THE LIABILITY OF TECHNOLOGY PUBLISHING AND THEIR AFFILIATES, AGENTS, AND LICENSORS, IF ANY, ARISING OUT OF ANY KIND OF LEGAL CLAIM IN ANY WAY CONNECTED TO THE SERVICE SHALL NOT EXCEED THE AMOUNT YOU PAID TO THE SERVICE FOR THE USE OF THE SERVICE.</p>
						</td>
					</tr>
					<tr>
						<td width="100%">
							<hr size="1" color="C0C0C0" noshade>
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;<br>
							&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!---End Main Form--->
</div>
</cfoutput>
