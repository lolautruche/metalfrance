{def $tags = str_replace( '|#', ', ', $node.data_map.tags.content.keyword_string )
     $title = concat( '[News] '|i18n( 'extension/metalfrance/rss' ), $node.name|wash )}
{if $tags|ne( '' )}{set $title = concat( $title, ' // ', $tags  )}{/if}
    <item>
      <title>{$title|shorten(140)}</title>
      <link>{str_replace( '/layout/set/rss', '', $node.url_alias|ezurl( 'no', 'full' ) )}</link>
      <description>
        {def $description = $node.data_map.body.content.output.output_text|strip_tags|trim|simplify|shortenw( 200 )}
        {str_replace( '&nbsp;', ' ', $description )}
      </description>
      <pubDate>{$node.object.published|datetime( 'custom', '%r' )}</pubDate>
      <guid isPermaLink="false">{concat( 'content/view/full/', $node.node_id )}</guid>
    </item>
