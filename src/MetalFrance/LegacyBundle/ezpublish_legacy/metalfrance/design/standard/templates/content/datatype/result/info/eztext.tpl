{if $attribute|get_class|eq( 'ezinformationcollectionattribute' )}

{$:attribute.data_text|wash|trim|simplify|nl2br}

{/if}
