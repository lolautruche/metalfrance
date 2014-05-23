{* Google Analytics *}
{* Définition de la catégorie *}
{if is_unset( $pagedata )}{def $pagedata = ezpagedata()}{/if}
{def $categoryByContentClass = ezini( 'TrackingSettings', 'CategoryByContentClass', 'metalfrance.ini' )
     $classIdentifier = $pagedata.class_identifier
     $categorie = ''}
{if is_set( $pagedata.persistent_variable.categorie_analytics )}
    {set $categorie = $pagedata.persistent_variable.categorie_analytics}
{elseif is_set( $categoryByContentClass[$classIdentifier] )}
    {set $categorie = $categoryByContentClass[$classIdentifier]}
{/if}
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '{ezini( 'TrackingSettings', 'GoogleAnalyticsAccount', 'metalfrance.ini' )}']);
  _gaq.push(['_setDomainName', '{ezini( 'TrackingSettings', 'GoogleAnalyticsDomain', 'metalfrance.ini' )}']);
  {if $categorie|ne( '' )}_gaq.push(['_setCustomVar', 1, '{'Categorie'}', "{$categorie|wash}", 3]);{/if}{* La catégorie utilise le slot #1, au niveau page (3) *}
  
  {def $userType = 'Anonymous'}
  {if $current_user.is_logged_in}
    {if $current_user.contentobject.class_identifier|eq( 'mf_user' )}
        {set $userType = $current_user.contentobject.data_map.account_type.content}
    {else}
        {set $userType = 'ezpublish'}
    {/if}
  {/if}
  _gaq.push(['_setCustomVar', 2, '{'UserType'}', "{$userType|wash}", 1]);
  _gaq.push(['_trackPageview']);
  _gaq.push(['_trackPageLoadTime']);

  (function() {ldelim}
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  {rdelim})();

</script>