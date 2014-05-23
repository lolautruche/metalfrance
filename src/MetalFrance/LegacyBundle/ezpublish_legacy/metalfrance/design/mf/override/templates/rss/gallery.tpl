    <item>
      <title>{'[Photos]'|i18n( 'extension/metalfrance/rss' )} {$node.name|wash}</title>
      <link>{str_replace( '/layout/set/rss', '', $node.url_alias|ezurl( 'no', 'full' ) )}</link>
      <description>
        {$node.data_map.lieu.content|wash} - {$node.data_map.date.content.timestamp|l10n( 'shortdate' )}
        {if $node.data_map.description.has_content}
            {def $description = $node.data_map.description.content.output.output_text|striptags|trim|simplify|shortenw( 300 )}
            {str_replace( '&nbsp;', ' ', $description )}
        {/if}
      </description>
      <pubDate>{$node.object.published|datetime( 'custom', '%r' )}</pubDate>
      <guid isPermaLink="false">{concat( 'content/view/full/', $node.node_id )}</guid>
    </item>
