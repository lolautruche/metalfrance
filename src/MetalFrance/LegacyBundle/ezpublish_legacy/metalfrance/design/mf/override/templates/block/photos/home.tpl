	<section class="mf-section mf-gallery-home">
	  <h2 class="mf-title">/// {$block.name}<span class="mf-sprite-header mf-sprite-photo"></span></h2>
	  <ul class="mf-list mf-photos mf-clear">
	  {foreach $block.valid_nodes as $valid_node}
	    {cache-block keys=array( 'gallery_home_block_item', $valid_node.node_id ) subtree_expiry=$valide_node.parent_node_id expiry=0}
		    <li>
		       <div class="mf-polaroid">
		           <div class="mf-polaroid-image">
		               <img src={$valid_node.children.0.data_map.image.content.polaroid.url|ezroot} alt="{'Photos de'|i18n( 'extension/metalfrance' )} {$valid_node.data_map.titre.content|wash}" />
	               </div>
	               <span><a href={str_replace( '/layout/set/rss', '', $valid_node.url_alias|ezurl )} class="mf-polaroid-link">{$valid_node.data_map.titre.content|wash}</a></span>
	               <div class="content">
	                   <h3>{'Photos live Métal de %titre à %lieu'|i18n( 'extension/metalfrance/gallery',, hash( '%titre', $valid_node.data_map.titre.content|wash,
	                                                                                                            '%lieu', $valid_node.data_map.lieu.content|wash ) )}</h3>
                     {if $valid_node.data_map.description.has_content}
                       <p>{$valid_node.data_map.description.content.output.output_text|striptags|trim|simplify|shortenw( 200 )}</p>
                     {/if}
	               </div>
	           </div>
	        </li>
	  
	    {/cache-block}
	  {/foreach}
	  </ul>
	  <p class="mf-view-all"><a href={"/photos"|ezurl}>{'Voir toutes les photos'|i18n( 'extension/metalfrance' )} &gt;</a></p>
	</section>