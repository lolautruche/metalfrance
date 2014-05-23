{* Categorie Analytics *}
{ezpagedata_set( 'categorie_analytics', 'Live reports' )}
{def $limit = ezini( 'GeneralSettings', 'ListLimit', 'metalfrance.ini' )
     $aReviews = fetch( 'content', 'tree', hash(
            'parent_node_id', $node.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'mf_livereport' ),
            'offset', $view_parameters.offset,
            'limit', $limit,
            'sort_by', array( 'published', false() ) 
     ) )
     $reviewCount = fetch( 'content', 'tree_count', hash(
            'parent_node_id', $node.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'mf_livereport' )
     ) )}
{* Colonne de droite *}
{ezpagedata_set( 'right_column', array( 'agenda', 'gallery' ) )}
          <h1 class="mf-title">/// {$node.name}<span class="mf-sprite-header mf-sprite-micro"></span></h1>
          
          <ul class="mf-list mf-chroniques">
          {foreach $aReviews as $review}
            {cache-block keys=array( 'list_item', $review.node_id ) subtree_expiry=$review.node_id expiry=0}
              {node_view_gui content_node=$review view='line'}
            
            {/cache-block}
          {/foreach}              
          </ul>
          
          {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$reviewCount
                     view_parameters=$view_parameters
                     item_limit=$limit}
