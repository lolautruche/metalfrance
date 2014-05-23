{* Output content name and link on the head of comment list *}
{* Content START *}
{def $aSpriteByContent = ezini( 'GeneralSettings', 'SpriteClassByContent', 'metalfrance.ini' )}
<h2{if is_unset( $aSpriteByContent[$contentobject.class_identifier] )} class="mf-title mf-noicon"{/if}>
    {'Commentaires sur %content'|i18n( 'extension/metalfrance',, hash( '%content', concat( '<em>', $contentobject.name|wash, '</em>' ) ) )}
    {if is_set( $aSpriteByContent[$contentobject.class_identifier] )}<span class="mf-sprite-header {$aSpriteByContent[$contentobject.class_identifier]}"></span>{/if}
</h2>
{* Content END *}