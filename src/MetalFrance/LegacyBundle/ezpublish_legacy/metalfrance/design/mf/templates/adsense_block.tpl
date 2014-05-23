{if ezini( 'AdSettings', 'DisplayAds', 'metalfrance.ini' )|eq( 'enabled' )}
  {def $blockIniName = concat( "Adsense_", $adsenseIdentifier )}
  {if ezini_hasvariable( $blockIniName, "AdSlotID", "metalfrance.ini" )}
	<script type="text/javascript"><!--
	google_ad_client = "{ezini( "AdSettings", "DFPPubID", "metalfrance.ini" )}";
	/* MF - Reviews */
	google_ad_slot = "{ezini( $blockIniName, "AdSlotID", "metalfrance.ini" )}";
	google_ad_width = {ezini( $blockIniName, "AdWidth", "metalfrance.ini" )};
	google_ad_height = {ezini( $blockIniName, "AdHeight", "metalfrance.ini" )};
	//-->
	</script>
	<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
  {/if}
  {undef $adsenseIdentifier}
{/if}
