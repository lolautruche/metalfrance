	<section class="mf-section">
	  <h2 class="mf-title">/// {$block.name}<span class="mf-sprite-header mf-sprite-cd"></span></h2>
	
	  <div id="coverflow_container">
	      <div id="coverflow">
	      
	      </div>
	      
	      <div class="mf-clear">
	          <a href="javascript:;" id="coverflow_left" title="{'Précédent'|i18n( 'extension/metalfrance/coverflow' )}">&lt;</a>
	
	          <div class="mf-album-name"></div>
	
	          <a href="javascript:;" id="coverflow_right" title="{'Suivant'|i18n( 'extension/metalfrance/coverflow' )}">&gt;</a>
	      </div>
	      
	      <div id="coverflow-items">
	      {foreach $block.valid_nodes as $valid_node}
	        {cache-block keys=array( 'coverflow_home_block_item', $valid_node.node_id ) subtree_expiry=$valid_node.parent_node_id expiry=0}
	          {node_view_gui view="line_coverflow" content_node=$valid_node}

            {/cache-block}
	      {/foreach}
	      </div>
	  </div>
	  <p class="mf-view-all"><a href={"/chroniques"|ezurl}>{'Lire toutes les chroniques'|i18n( 'extension/metalfrance' )} &gt;</a></p>
	</section>