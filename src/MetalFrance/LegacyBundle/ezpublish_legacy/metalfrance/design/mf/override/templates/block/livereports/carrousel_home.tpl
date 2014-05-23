	<section class="mf-section">
	    <h2 class="mf-title">/// {$block.name}<span class="mf-sprite-header mf-sprite-micro"></span></h2>

	      <div id="featured" >
	          <ul class="ui-tabs-nav">
	          {foreach $block.valid_nodes as $i => $valid_node}
	            {cache-block keys=array( 'livereports_home_carrousel_line_item', $valid_node.node_id ) subtree_expiry=$valid_node.parent_node_id expiry=0}
	              {node_view_gui view="carrousel_line" content_node=$valid_node id=concat( 'fragment-', $valid_node.node_id ) navid=concat( 'nav-fragment-', $valid_node.node_id )}

	            {/cache-block}
	          {/foreach}
	          </ul>

	          {foreach $block.valid_nodes as $i => $valid_node}
	            {cache-block keys=array( 'livereports_home_carrousel_item', $valid_node.node_id ) subtree_expiry=$valid_node.parent_node_id expiry=0}
	              {node_view_gui view="carrousel" content_node=$valid_node id=concat( 'fragment-', $valid_node.node_id )}

	            {/cache-block}
	          {/foreach}
	        </div>
	  <p class="mf-view-all"><a href={"/live-reports"|ezurl}>{'Voir tous les live reports'|i18n( 'extension/metalfrance' )} &gt;</a></p>
	  <p class="mf-view-all"><a href={"/interviews"|ezurl}>{'Voir toutes les interviews'|i18n( 'extension/metalfrance' )} &gt;</a></p>
	</section>