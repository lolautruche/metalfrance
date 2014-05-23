            <li>
              <article>
                  <h3><a href={$node.url_alias|ezurl} rel="nofollow">{$node.name}</a> <span class="mf-news-date">{$node.object.published|l10n( 'shortdatetime' )}</span></h3>
                  <p>{$node.data_map.body.content.output.output_text|strip_tags|trim|simplify|shortenw( 200 )}</p>
                  <footer><a href={$node.url_alias|ezurl}>{"Lire la suite de l'actualité %actu"|i18n( 'extension/metalfrance/news',, hash( '%actu', $node.name ) )}</a></footer>
              </article>
            </li>