{if is_set( $module_result.content_info.persistent_variable.amazon_item )}
        <section id="mf-amazon-player" class="mf-section">
          <h3><a href={$module_result.content_info.persistent_variable.amazon_item.url} class="mf-amazon-big" target="_blank">{'Télécharger légalement'|i18n( 'extension/metalfrance' )}</a></h3>
          
          <script type='text/javascript'>
            var amzn_wdgt={ldelim}widget:'MP3Clips'{rdelim};
            amzn_wdgt.tag='{ezini( 'AssociateSettings', 'AssociateTag', 'amazonadvertising.ini' )}';
            amzn_wdgt.widgetType='ASINList';
            amzn_wdgt.ASIN='{$module_result.content_info.persistent_variable.amazon_item.id}';
            amzn_wdgt.title='{'Écouter %album'|i18n( 'extension/metalfrance/review',, hash( '%album', $module_result.content_info.persistent_variable['review_title'] ) )}';
            amzn_wdgt.width='250';
            amzn_wdgt.height='250';
            amzn_wdgt.shuffleTracks='False';
            amzn_wdgt.marketPlace='FR';
          </script>
          <script type='text/javascript' src={'http://wms.assoc-amazon.fr/20070822/FR/js/swfobject_1_5.js'|ezurl}></script>
        </section>
{/if}