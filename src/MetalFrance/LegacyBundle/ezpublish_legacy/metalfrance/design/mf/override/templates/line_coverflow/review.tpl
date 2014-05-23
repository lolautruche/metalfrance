{def $artiste = fetch( 'content', 'related_objects', hash( 
          'object_id', $node.contentobject_id,
          'attribute_identifier', 'mf_chronique_cd/artiste' 
     ) ).0
     $album = $node.data_map.album.content|wash}
		<div class="mf-coverflow-item">
		    <h3 class="mf-review">
		      <a class="mf-review-link" id="mf-review-coverflow-{$node.node_id}" title="{'Lire la suite de la chronique sur %album'|i18n( 'extension/metalfrance/review',, hash( '%album', $album ) )}" href={str_replace( '/layout/set/rss', '', $node.url_alias|ezurl )}>
		        {$node.name}
		      </a>
		    </h3>
		    <img class="mf-coverflow-image" src={$node.data_map.pochette.content.coverflow.url|ezroot} alt="{"Pochette de l'album %album par %artiste"|i18n( 'extension/metalfrance/review',, hash( '%album', $album, '%artiste', $artiste.name ) )}" />
		    <p>{attribute_view_gui attribute=$node.data_map.introduction}</p>
		</div>