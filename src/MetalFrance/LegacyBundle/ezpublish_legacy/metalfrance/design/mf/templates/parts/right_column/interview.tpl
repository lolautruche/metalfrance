{def $aReviews = fetch( 'content', 'tree', hash(
            'parent_node_id', 2,
            'class_filter_type', 'include',
            'class_filter_array', array( 'mf_interview' ),
            'offset', $view_parameters.offset,
            'limit', 5,
            'sort_by', array( 'published', false() ) 
     ) )}
{if $aReviews}
        <section class="mf-section mf-other">
          <h4 class="mf-title">/// {'Interviews'|i18n( 'extension/metalfrance' )}<span class="mf-sprite-header mf-sprite-micro"></span></h4>
        
        {foreach $aReviews as $result}
          {cache-block keys=array( 'relatedcontent_list_item', $result.node_id ) subtree_expiry=$result.node_id expiry=0}
            {node_view_gui content_node=$result view='ezfind_line'}
          {/cache-block}
          
        {/foreach}
        </section>
{/if}