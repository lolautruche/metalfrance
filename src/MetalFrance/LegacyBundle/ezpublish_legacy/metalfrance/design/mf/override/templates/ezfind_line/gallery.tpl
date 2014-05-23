<article>
  <div class="mf-related gallery">
    <h5><span>{'Photos'|i18n( 'extension/metalfrance' )}</span> <a href={$node.url_alias|ezurl} rel="nofollow">{$node.data_map.titre.content|wash}</a></h4>
    <p>
      <a href={$node.url_alias|ezurl}>{$node.data_map.lieu.content|wash} - {$node.data_map.date.content.timestamp|l10n( 'shortdate' )}</a>
    </p>
  </div>
</article>