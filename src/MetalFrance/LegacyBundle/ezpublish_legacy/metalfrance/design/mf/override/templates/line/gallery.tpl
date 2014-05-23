{def $firstPhoto = fetch( 'content', 'list', hash(
        'parent_node_id', $node.node_id,
        'class_filter_type', 'include',
        'class_filter_array', array( 'image' ),
        'sort_by', array( 'priority', false() ),
        'limit', 1
     ) ).0}
            <li>
              <article>
	            <div class="listImageWrapper">
	              <a href={$node.url_alias|ezurl} rel="nofollow">
	                <img src={$firstPhoto.data_map.image.content.review_list.url|ezroot} alt="{"Image de la galerie photo %galerie"|i18n( 'extension/metalfrance/gallery',, hash( '%galerie', $node.name|wash ) )}" />
	              </a>
	            </div>
	              <h3><a href={$node.url_alias|ezurl} rel="nofollow">{$node.name}</a></h3>
	              <p>{$node.data_map.lieu.content|wash} - {$node.data_map.date.content.timestamp|l10n( 'shortdate' )}</p>
	              {if $node.data_map.description.has_content}
	              <p>{$node.data_map.description.content.output.output_text|striptags|trim|simplify|shortenw( 300 )}</p>
	              {/if}
	              <footer><a href={$node.url_alias|ezurl}>{'Voir la galerie photo %galerie'|i18n( 'extension/metalfrance/gallery',, hash( '%galerie', $node.name ) )}</a></footer>
	          </article>
            </li>