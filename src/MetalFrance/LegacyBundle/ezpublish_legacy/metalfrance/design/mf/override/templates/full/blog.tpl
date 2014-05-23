{def $limit = ezini( 'NewsSettings', 'ListLimit', 'metalfrance.ini' )
     $aNews = fetch( 'content', 'tree', hash(
            'parent_node_id', $node.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'blog_post' ),
            'offset', $view_parameters.offset,
            'limit', $limit,
            'sort_by', array( 'published', false() ) 
     ) )
     $newsCount = fetch( 'content', 'tree_count', hash(
            'parent_node_id', $node.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'blog_post' )
     ) )}
          <h1 class="mf-title">/// {'Actualités Métal'|i18n( 'extension/metalfrance/news' )}<span class="mf-sprite-header mf-sprite-news"></span></h1>
          
          <ul class="mf-list mf-news">
          {foreach $aNews as $news}
            {cache-block keys=array( 'list_item', $news.node_id ) subtree_expiry=$news.node_id expiry=0}
              {node_view_gui content_node=$news view='line'}
            
            {/cache-block}
          {/foreach}              
          </ul>
          
          {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=$node.url_alias
                     item_count=$newsCount
                     view_parameters=$view_parameters
                     item_limit=$limit}
