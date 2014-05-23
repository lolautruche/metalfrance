<!DOCTYPE html> 
<html lang="{$site.http_equiv.Content-language|wash}"> 
<head>
{def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

{def $extra_cache_key = ''}
{* Extra cache key avec le moteur de recherche (pour analytics notamment) *}
{if $module_result.uri|contains( 'content/search' )}
    {def $searchMode = 'regular'}
    {if ezhttp_hasvariable( 'mode', 'get' )}{set $searchMode = ezhttp( 'mode', 'get' )}{/if}
    {set $extra_cache_key = concat( 'search_mode_', $searchMode )}
{/if}

{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}
{def $pagedata         = ezpagedata()
     $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $pagedesign       = $pagedata.template_look
     $current_node_id  = $pagedata.node_id}

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>
<body>
    <script type="text/javascript">document.body.className = 'mf-js';</script>
      
  <!-- Header area: START -->
  {include uri='design:page_header.tpl'}
  <!-- Header area: END -->

  {cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

  <!-- NAV -->
  {include uri='design:page_topmenu.tpl'}
  <!-- /NAV -->
  
  {*<!-- Path area: START -->
  {if $pagedata.show_path}
    {include uri='design:page_toppath.tpl'}
  {/if}
  <!-- Path area: END -->*}
  
  <!-- Toolbar area: START -->
  {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
    {include uri='design:page_toolbar.tpl'}
  {/if}
  <!-- Toolbar area: END -->

  {/cache-block}
{/cache-block}

    <!-- CONTENT -->
    {include uri='design:page_mainarea.tpl'}
    <!-- /CONTENT -->
    
{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

    {if is_unset($pagedesign)}
        {def $pagedata   = ezpagedata()
             $pagedesign = $pagedata.template_look}
    {/if}

    {*<!-- Extra area: START -->
    {if $pagedata.extra_menu}
        {include uri='design:page_extramenu.tpl'}
    {/if}
    <!-- Extra area: END -->*}

    <!-- Columns area: END -->

    <!-- FOOTER -->
    {include uri='design:page_footer.tpl'}
    <!-- /FOOTER -->

	<!-- Complete page area: END -->
	
	<!-- Footer script area: START -->
	{include uri='design:page_footer_script.tpl'}
	<!-- Footer script area: END -->

{/cache-block}

    
</body>
</html>