{def $newsNodeID = ezini( 'NodeSettings', 'News', 'metalfrance.ini' )}
{cache-block keys=array( 'mf-news', 'header', 'carrousel' ) subtree_expiry=$newsNodeID}
          <section id="mf-actu" class="mf-section mf-clear">
            <h3 class="mf-title mf-noicon">/// {'Actualités'|i18n( 'extension/metalfrance' )}</h3>
            
            {def $aNews = fetch( 'content', 'list', hash(
                              'parent_node_id', $newsNodeID,
                              'class_filter_type', 'include',
                              'class_filter_array', array( 'blog_post' ),
                              'sort_by', array( 'published', false() ),
                              'limit', ezini( 'NewsSettings', 'HeaderNewsCount', 'metalfrance.ini' )
                          ) )}
            <div id="actu-carousel" class="jcarousel-container">
                <div class="jcarousel-clip">
                    <ul class="jcarousel-list">
                    {foreach $aNews as $i => $news}
                        <li class="jcarousel-item-{$i|inc}">
                        {node_view_gui content_node=$news view='carrousel'}
                        </li>
                        
                    {/foreach}
                    </ul>
                </div>
            </div>
            
            <ul class="mf-page mf-clear">
            {foreach $aNews as $i => $news}
              <li><a href="#{$i|inc}" title="Actus - Page {$i|inc}">{$i|inc}</a></li>
            {/foreach}
            </ul>
          </section>
{/cache-block}
