{def $imageUrl = cond( $node.data_map.image.has_content, $node.data_map.image.content.review_list.url|ezroot, 'image-listing.png'|ezimage )}
    <li>
      <article>
        <div class="listImageWrapper">
          <a href={$node.url_alias|ezurl} rel="nofollow">
            <img src={$imageUrl} alt="{"Photo de l'interview %interview"|i18n( 'extension/metalfrance/interview',, hash( '%interview', $node.name|wash ) )}" />
          </a>
        </div>
          <h3><a href={$node.url_alias|ezurl} rel="nofollow">{$node.name}</a></h3>
          <p>{$node.data_map.introduction.content.output.output_text|striptags|trim|simplify|shortenw( 400 )}</p>
          <footer><a href={$node.url_alias|ezurl}>{"Lire la suite de l'interview de %interview"|i18n( 'extension/metalfrance/interview',, hash( '%interview', $node.name ) )}</a></footer>
      </article>
    </li>
