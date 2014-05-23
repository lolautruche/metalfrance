<article>
  <div class="mf-related livereport">
    <h5><span>{'Live report'|i18n( 'extension/metalfrance' )}</span> <a href={$node.url_alias|ezurl} rel="nofollow">{$node.name}</a></h4>
    <p>
      <a href={$node.url_alias|ezurl}>{$node.data_map.contenu.content.output.output_text|striptags|trim|simplify|shortenw( 150 )}</a>
    </p>
  </div>
</article>