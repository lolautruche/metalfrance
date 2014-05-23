{def $classFilter = ezini( 'RelatedContentSettings', 'DefaultRelatedContentClasses', 'metalfrance.ini' )
     $classFilterSettingName = concat( $module_result.content_info.class_identifier, 'ContentClasses' )}
{if ezini_hasvariable( 'RelatedContentSettigs', $classFilterSettingName, 'metalfrance.ini' )}{set $classFilter = ezini( 'RelatedContentSettings', $classFilterSettingName, 'metalfrance.ini' )}{/if}
{def $relatedContent = fetch( 'ezfind', 'moreLikeThis', hash(
            'query_type', 'nid',
            'query', $module_result.content_info.node_id,
            'class_id', $classFilter,
            'limit', 5
     ) )}
{if $relatedContent['SearchResult']}
        <section class="mf-section mf-other">
          <h4 class="mf-title mf-noicon">/// {'Contenu similaire'|i18n( 'extension/metalfrance' )}</h4>
        
        {foreach $relatedContent['SearchResult'] as $result}
          {cache-block keys=array( 'relatedcontent_list_item', $result.node_id ) subtree_expiry=$result.node_id expiry=0}
            {node_view_gui content_node=$result view='ezfind_line'}
          {/cache-block}
          
        {/foreach}
        </section>
{/if}