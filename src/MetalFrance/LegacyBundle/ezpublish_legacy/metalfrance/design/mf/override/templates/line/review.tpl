            <li>
              <article>
	              <a href={$node.url_alias|ezurl} rel="nofollow"><img src={$node.data_map.pochette.content.review_list.url|ezroot} alt="{"Pochette de %album"|i18n( 'extension/metalfrance/review',, hash( '%album', $node.name ) )}" /></a>
	              <h3><a href={$node.url_alias|ezurl} rel="nofollow">{$node.name}</a></h3>
	              <p>{$node.data_map.introduction.content|wash|trim|simplify|shortenw( 400 )}</p>
	              <footer><a href={$node.url_alias|ezurl}>{'Lire la suite de la chronique sur %album'|i18n( 'extension/metalfrance/review',, hash( '%album', $node.name ) )}</a></footer>
	          </article>
            </li>