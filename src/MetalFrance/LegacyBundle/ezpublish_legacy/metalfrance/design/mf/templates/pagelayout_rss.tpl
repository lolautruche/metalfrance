<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
{cache-block keys=array( 'rss', 'feed' ) expiry=0 subtree_expiry=2}
  {def $siteURL = concat( 'http://', ezini( 'SiteSettings', 'SiteURL' ) )
       $aItems = fetch_alias( 'mf_rssfeed' )}
  <channel>
    <title>{$site.title}</title>
    <link>{$siteURL}</link>
    <description>{ezini( 'SiteSettings', 'MetaDataArray' ).description}</description>
    <language>{'fr-FR'}</language>
    <copyright>{"Copyright © 2011 Metal France. Tous droits réservés."|i18n( 'extension/metalfrance' )}</copyright>
    <atom:link href="{$siteURL}/layout/set/rss/content/view/full/2" rel="self" type="application/rss+xml"/>
    
{foreach $aItems as $item}
  {cache-block keys=array( 'rss_item', $item.node_id ) expiry=0 subtree_expiry=$item.node_id}
    {node_view_gui content_node=$item view="rss"}
    
  {/cache-block}
{/foreach}
  </channel>
  
{/cache-block}
</rss>
<!--<!--DEBUG_REPORT-->-->