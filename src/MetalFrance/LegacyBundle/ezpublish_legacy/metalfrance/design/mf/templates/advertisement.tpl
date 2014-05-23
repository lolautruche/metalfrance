{if ezini( 'AdSettings', 'DisplayAds', 'metalfrance.ini' )|eq( 'enabled' )}
<!-- Google ads DFP -->
<!-- 
    Loading with iFrame Method : http://goo.gl/KbXnP
    Using asynchronous loading hack : http://goo.gl/sDBJb - http://goo.gl/2Yja8 
-->
<script type="text/javascript" src="http://partner.googleadservices.com/gampad/google_service.js"></script>
<script type='text/javascript'>
    GS_googleAddAdSenseService("{ezini( 'AdSettings', 'DFPPubID', 'metalfrance.ini' )}");
    GS_googleEnableAllServices();
</script>
<script type='text/javascript'>
    GA_googleUseIframeRendering();
    {*GA_googleAddAdSensePageAttr("google_color_bg", "F0F0F0");
    GA_googleAddAdSenseSlotAttr("AdUnitName", "google_color_bg", "F0F0F0");*}
</script>
<!-- /Google ads DFP -->

{/if}
